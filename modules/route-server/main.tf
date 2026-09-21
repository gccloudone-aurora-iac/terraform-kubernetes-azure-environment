# Manages an Azure Public IP address used by the Route Server.
# Only an IP address with the standard SKU can be used by the Route Server.
#
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
#
resource "azurerm_public_ip" "this" {
  name                = module.azure_resource_names.public_ip_address_route_server_name
  resource_group_name = var.resource_group_name
  location            = var.azure_resource_attributes.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = local.tags
}

####################
### Route Server ###
####################

# Manages an Azure Route Server.
#
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_server
#
resource "azurerm_route_server" "this" {
  name                = module.azure_resource_names.route_server_name
  resource_group_name = var.resource_group_name
  location            = var.azure_resource_attributes.location

  sku                              = var.sku
  public_ip_address_id             = azurerm_public_ip.this.id
  subnet_id                        = var.subnet_id
  branch_to_branch_traffic_enabled = var.branch_to_branch_traffic_enabled

  tags = local.tags
}

# Adds peer(s) to the Route Server.
#
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_server_bgp_connection
#
resource "azurerm_route_server_bgp_connection" "this" {
  count = length(var.bgp_peers)

  name            = var.bgp_peers[count.index].name
  route_server_id = azurerm_route_server.this.id
  peer_asn        = var.bgp_peers[count.index].peer_asn
  peer_ip         = var.bgp_peers[count.index].peer_ip
}
