locals {
  tags = merge(
    var.tags,
    {
      ModuleName    = "terraform-azure-storage-account",
      ModuleVersion = "v5.0.0",
    }
  )
}
