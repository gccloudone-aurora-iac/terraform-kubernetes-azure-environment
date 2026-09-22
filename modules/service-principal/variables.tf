variable "azure_resource_attributes" {
  description = "The attributes used to name and tag the Azure resources"
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
  description = "A user-defined segment included in the name of every Azure resource."
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

variable "description" {
  description = "The description shown to end users on the application registration."
  type        = string
  default     = null
}

variable "notes" {
  description = "Internal notes on the application registration, visible only to administrators."
  type        = string
  default     = null
}

###################
### Application ###
###################

variable "owners" {
  description = "A set of object IDs of principals that will be granted ownership of the application registration & service principal. Supported object types are users or service principals."
  type        = list(string)
  default     = []
}

variable "web_redirect_uris" {
  description = "The application's redirect URIs."
  type        = list(string)
  default     = []
}

variable "application_password" {
  description = "Specifies if a password will be created within the application registration and if so how often the secret will be rotated."
  type = object({
    enable        = optional(bool, true)
    rotation_days = optional(number, 365) # If null, the secret will never be rotated
  })
  default = {
    enable        = true
    rotation_days = 365
  }
}

variable "roles_and_members" {
  description = "The app roles to create on the application registration, and the members assigned to each."
  type = map(object({
    description          = optional(string)
    allowed_member_types = optional(list(string), ["User"])
    value                = optional(string)
    members              = map(string) # key is display name and value should be object ID
  }))
  default = {}
}

### Claims ###

variable "group_membership_claims" {
  description = "Configures the groups claim issued in a user or OAuth access token that the app expects. Possible values are None, SecurityGroup, DirectoryRole, ApplicationGroup or All."
  type        = list(string)
  default     = []
}

variable "optional_claims" {
  description = "The optional claims to add to the tokens issued for this application."
  type = object({
    access_tokens = list(object({
      name                  = string
      additional_properties = optional(list(string))
      essential             = optional(bool)
      source                = optional(string)
    }))
    id_tokens = list(object({
      name                  = string
      additional_properties = optional(list(string))
      essential             = optional(bool)
      source                = optional(string)
    }))
    saml2_tokens = list(object({
      name                  = string
      additional_properties = optional(list(string))
      essential             = optional(bool)
      source                = optional(string)
    }))
  })
  default = null
}

variable "api_permissions" {
  description = "API permissions to grant to the application registration."
  type = map(object({
    api_client_id = string
    role_names    = optional(list(string), [])
    scope_names   = optional(list(string), [])
  }))
  default = {}
}