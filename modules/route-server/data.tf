data "azurerm_virtual_hub" "this" {
  name                = azurerm_route_server.this.name
  resource_group_name = azurerm_route_server.this.resource_group_name
}
