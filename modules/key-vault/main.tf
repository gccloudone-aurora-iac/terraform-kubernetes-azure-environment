###############
## Key Vault ##
###############

resource "azurerm_key_vault" "this" {
  name                = module.key_vault_name.key_vault_name
  resource_group_name = var.resource_group_name
  location            = var.azure_resource_attributes.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                   = var.sku_name
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  enabled_for_deployment          = var.public_network_access_enabled ? var.resource_access.enabled_for_deployment : null
  enabled_for_template_deployment = var.public_network_access_enabled ? var.resource_access.enabled_for_template_deployment : null
  enabled_for_disk_encryption     = var.public_network_access_enabled ? var.resource_access.enabled_for_disk_encryption : null
  enable_rbac_authorization       = var.enable_rbac_authorization

  public_network_access_enabled = var.public_network_access_enabled
  network_acls {
    default_action             = var.default_network_access_action
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = var.service_endpoint_subnet_ids
    ip_rules                   = var.ip_rules
  }

  tags = local.tags
}

#########################
### Private Endpoints ###
#########################

resource "azurerm_private_endpoint" "this" {
  for_each = { for index, endpoint in var.private_endpoints : index => endpoint }

  name                = "${module.azure_resource_names.private_endpoint_name}-${var.user_defined}-${each.value.sub_resource_name}"
  location            = var.azure_resource_attributes.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = each.value.private_dns_zone_id != null ? [1] : []
    content {
      name                 = "default"
      private_dns_zone_ids = [each.value.private_dns_zone_id]
    }
  }

  private_service_connection {
    name                           = "${module.azure_resource_names.private_endpoint_name}-${var.user_defined}-${each.value.sub_resource_name}"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = [each.value.sub_resource_name]
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [private_dns_zone_group]
  }
}
