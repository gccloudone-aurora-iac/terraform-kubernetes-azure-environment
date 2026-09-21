locals {
  tags = merge(
    var.tags,
    {
      ModuleName    = "terraform-azure-route-server",
      ModuleVersion = "v1.0.0",
    }
  )
}
