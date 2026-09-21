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
  description = "Name of the resource group to be used for the route server."
  type        = string
  nullable    = false
}

variable "sku" {
  description = "The SKU of the route server."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "The tags to assign to the public IP"
  type        = map(string)
  default     = {}
}

############################
### Unique RS Attributes ###
############################

variable "subnet_id" {
  description = "The ID of the Subnet that the Route Server will reside. Changing this forces a new resource to be created."
  type        = string
}

variable "branch_to_branch_traffic_enabled" {
  description = "Whether to enable route exchange between Azure Route Server and the gateway(s)."
  type        = bool
  default     = false
}

variable "bgp_peers" {
  description = "The details for creating a BGP connection within the route server."
  type = list(object({
    name     = string
    peer_asn = number
    peer_ip  = string
  }))
}
