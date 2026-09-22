module "azure_resource_names" {
  source = "../resource-names"

  naming_convention = var.naming_convention
  user_defined      = var.user_defined

  name_attributes = var.azure_resource_attributes
}


module "key_vault_name" {
  source = "../resource-names-global"

  naming_convention = var.naming_convention
  user_defined      = var.user_defined

  name_attributes = var.azure_resource_attributes
}
