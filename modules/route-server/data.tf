# Looks up the Virtual Hub backing the Route Server, for its BGP peering details.
#
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_hub
#
data "azurerm_virtual_hub" "this" {
  name                = azurerm_route_server.this.name
  resource_group_name = azurerm_route_server.this.resource_group_name
}
