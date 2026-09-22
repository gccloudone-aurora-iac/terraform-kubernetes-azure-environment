locals {
  tags = merge(
    var.tags,
    {
      ModuleName    = "terraform-azure-key-vault",
      ModuleVersion = "v5.0.0",
    }
  )
}
