#############################
#   GC NAMING CONVENTION    #
#############################

locals {
  location_table_gc = {
    "canadacentral" = "c"
    "canadaeast"    = "d"
  }
}

locals {
  location_gc = lookup(local.location_table_gc, replace(lower(var.name_attributes.location), " ", ""))

  common_convention_base_gc = "${var.name_attributes.department_code}${var.name_attributes.environment}${local.location_gc}"

  project_gc       = replace(var.name_attributes.project, "-", "")
  project_gc_short = substr(local.project_gc, 0, 5)

  resource_type_abbreviations_gc = {
    "azure data factory" = "adf"
    "container registry" = "registry"
    "function app"       = "fn"
    "key vault"          = "kv"
    "postgresql server"  = "psql"
  }

  resource_type_abbreviations_gc_custom = {
    "data lake store"           = "${lower(local.common_convention_base_gc)}${lower(local.project_gc)}${lower(var.user_defined)}${local.random_number}"
    "storage account"           = "${lower(local.common_convention_base_gc)}${lower(local.project_gc)}${lower(var.user_defined)}${local.random_number}"
    "storage account container" = "${lower(local.common_convention_base_gc)}${lower(local.project_gc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
    "storage account file"      = "${lower(local.common_convention_base_gc)}${lower(local.project_gc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
    "storage account queue"     = "${lower(local.common_convention_base_gc)}${lower(local.project_gc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
    "storage account table"     = "${lower(local.common_convention_base_gc)}${lower(local.project_gc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"
  }

  resource_names_gc = merge(
    {
      for resource_type, abbrev in local.resource_type_abbreviations_gc :
      resource_type => "${local.common_convention_base_gc}-${local.project_gc_short}-${var.user_defined}-${local.random_number}-${abbrev}"
    },
    local.resource_type_abbreviations_gc_custom
  )
}
