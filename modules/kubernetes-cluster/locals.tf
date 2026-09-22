locals {
  tags = merge(
    var.tags,
    {
      ModuleName    = "terraform-azure-kubernetes-cluster",
      ModuleVersion = "v5.0.0",
    }
  )
}
