##############################
#   OSS NAMING CONVENTION    #
##############################

locals {
  location_table_oss = {
    "canadacentral" = "cc"
    "canadaeast"    = "ce"
  }
}

locals {
  location_oss = lookup(local.location_table_oss, replace(lower(var.name_attributes.location), " ", ""))

  common_convention_base_oss = ""

  resource_type_abbreviations_oss = {
    "azure data factory" = "adf"
    "container registry" = "acr"
    "function app"       = "fn"
    "key vault"          = "kv"
    "postgresql server"  = "psql"
  }

  resource_type_abbreviations_oss_custom = {
    "data lake store"           = "dls${lower(local.common_convention_base_oss)}${local.random_number}${lower(var.user_defined)}"
    "storage account"           = "sa${lower(local.common_convention_base_oss)}${local.random_number}${lower(var.user_defined)}"
    "storage account container" = "${lower(local.common_convention_base_oss)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
    "storage account file"      = "${lower(local.common_convention_base_oss)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
    "storage account queue"     = "${lower(local.common_convention_base_oss)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
    "storage account table"     = "${lower(local.common_convention_base_oss)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
  }

  resource_names_oss = merge(
    {
      for resource_type, abbrev in local.resource_type_abbreviations_oss :
      resource_type => "${local.common_convention_base_oss}${abbrev}${local.random_number}${var.user_defined}"
    },
    local.resource_type_abbreviations_oss_custom
  )
}
