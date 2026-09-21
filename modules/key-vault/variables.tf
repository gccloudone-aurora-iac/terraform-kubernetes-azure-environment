
variable "azure_resource_attributes" {
  description = "Attributes used to describe Azure resources"
  type = object({
    department_code = string
    owner           = string
    project         = string
    environment     = string
    location        = optional(string, "Canada Central")
    instance        = number
  })
  nullable = false
}

variable "user_defined" {
  description = "A user-defined field that describes the Azure resource."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.user_defined) >= 2 && length(var.user_defined) <= 15
    error_message = "The user-defined field must be between 2-15 characters long."
  }
}

variable "naming_convention" {
  type        = string
  default     = "oss"
  description = "Sets which naming convention to use. Accepted values: oss, gc"
  validation {
    condition     = var.naming_convention == "oss" || var.naming_convention == "gc"
    error_message = "The naming_convention field must either be 'oss' or 'gc'."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which resources will be created"
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
}

variable "tags" {
  description = "Tags to set on the Azure Key Vault"
  type        = map(string)
  default     = {}
}

##################################
### Secret Deletion Protection ###
##################################

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault?"
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This field can't be updated."
  type        = number
  default     = 7
}

##############################
### Identity & Permissions ###
##############################

variable "resource_access" {
  description = "Determines what kind of resources can access secrets."
  type = object({
    enabled_for_deployment          = bool
    enabled_for_template_deployment = bool
    enabled_for_disk_encryption     = bool
  })
  default = {
    enabled_for_deployment          = false
    enabled_for_template_deployment = false
    enabled_for_disk_encryption     = false
  }
}

variable "enable_rbac_authorization" {
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. The alternative is using vault access policy for authorization."
  type        = bool
  default     = false
}

##################
### Networking ###
##################

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this Key Vault. If false, only private endpoints can be created."
  type        = bool
  default     = false
}

variable "default_network_access_action" {
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
  type        = string
  default     = "Deny"
}

variable "ip_rules" {
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "service_endpoint_subnet_ids" {
  description = "The service endpoints to configure on the key vault."
  type        = list(string)
  default     = []
}

variable "private_endpoints" {
  description = "The information required to create a private endpoint for the Key Vault."
  type = list(object({
    sub_resource_name   = optional(string, "vault")
    subnet_id           = string
    private_dns_zone_id = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for entry in var.private_endpoints :
      contains(["vault"], entry.sub_resource_name)
    ])
    error_message = "Invalid sub_resource_name within var.private_endpoints. Expected the name to be 'vault'."
  }
  validation {
    condition = (
      var.private_endpoints == null ||
      alltrue([
        for entry in var.private_endpoints :
        entry.private_dns_zone_id == null ? true : (
          can(element(split("/", entry.private_dns_zone_id), 8)) &&
          element(split("/", entry.private_dns_zone_id), 8) == "privatelink.vaultcore.azure.net"
        )
      ])
    )
    error_message = "Invalid private_dns_zone_id attribute within var.private_endpoints. Expected a Private DNS Zone with the name 'privatelink.vaultcore.azure.net'"
  }
}
