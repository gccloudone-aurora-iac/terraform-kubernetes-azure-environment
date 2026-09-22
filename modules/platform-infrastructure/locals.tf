locals {
  tags = merge(var.tags, { ModuleName = "terraform-kubernetes-azure-environment-platform-infrastructure" }, { ModuleVersion = "v5.0.0" })
}
