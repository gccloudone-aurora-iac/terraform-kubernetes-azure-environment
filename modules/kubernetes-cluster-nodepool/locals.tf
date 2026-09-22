locals {
  tags = merge(var.tags, { ModuleName = "terraform-azure-kubernetes-cluster-nodepool" }, { ModuleVersion = "v5.0.0" })
}
