locals {
  tags = merge(
    var.tags,
    {
      ModuleName    = "terraform-azure-key-vault",
      ModuleVersion = "v1.0.0",
    }
  )
}
