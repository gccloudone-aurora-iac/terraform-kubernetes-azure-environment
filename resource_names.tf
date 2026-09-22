module "azure_resource_names" {
  source = "./modules/resource-names"

  naming_convention = var.naming_convention
  user_defined      = var.user_defined

  name_attributes = var.azure_resource_attributes
}
