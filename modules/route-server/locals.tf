locals {
  tags = merge(
    var.tags,
    {
      ModuleName    = "terraform-azure-route-server",
      ModuleVersion = "v5.0.0",
    }
  )
}
