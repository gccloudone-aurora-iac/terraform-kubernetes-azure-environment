#########################
### Public IP Address ###
#########################

output "public_ip_id" {
  description = "The id of the public IP used by the route server"
  value       = azurerm_public_ip.this.id
}

output "public_ip_address" {
  description = "The IP address of the public IP used by the route server"
  value       = azurerm_public_ip.this.ip_address
}

####################
### Route Server ###
####################

output "id" {
  description = "The id of the Route Server"
  value       = azurerm_route_server.this.id
}

output "route_server_ip_addresses" {
  description = "The peer IP addresses of the Route Server. In other words, it is the private IPs of the route server."
  value       = data.azurerm_virtual_hub.this.virtual_router_ips
}

output "asn" {
  description = "The Autonomous System Number of the Virtual Hub BGP router."
  value       = data.azurerm_virtual_hub.this.virtual_router_asn
}

output "bgp_peers" {
  description = "The ids of the BGP peers"
  value       = azurerm_route_server_bgp_connection.this[*].id
}
