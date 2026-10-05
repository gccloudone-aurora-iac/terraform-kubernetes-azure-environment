# AKS owns the Gateway API CRDs and upgrades their bundle with Kubernetes.
# The controller is installed separately by the Aurora platform application.
# https://learn.microsoft.com/azure/aks/managed-gateway-api
resource "azapi_update_resource" "gateway_api" {
  count = var.gateway_api_enabled ? 1 : 0

  type        = "Microsoft.ContainerService/managedClusters@2025-09-02-preview"
  resource_id = azurerm_kubernetes_cluster.this.id
  body = {
    properties = {
      ingressProfile = {
        gatewayAPI = {
          installation = "Standard"
        }
      }
    }
  }

  response_export_values = ["properties.ingressProfile.gatewayAPI"]
}
