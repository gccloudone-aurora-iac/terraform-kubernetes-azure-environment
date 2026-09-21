locals {
  tags = merge(
    var.tags,
    {
      ModuleName    = "terraform-azure-kubernetes-cluster",
      ModuleVersion = "v1.0.0",
    }
  )
}
