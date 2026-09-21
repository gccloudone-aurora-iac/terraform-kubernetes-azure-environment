output "id" {
  description = "The Azure assigned ID generated after the KeyVault resource is created and available."
  value       = azurerm_key_vault.this.id
}

output "uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.this.vault_uri
}

output "name" {
  description = "The name of the key vault."
  value       = azurerm_key_vault.this.name
}

#########################
### Private Endpoints ###
#########################

output "private_endpoint_ids" {
  description = "The Azure resource IDs of the private endpoints created."
  value = tomap({
    for k, v in azurerm_private_endpoint.this : k => v.id
  })
}

output "private_endpoint_ip_config" {
  description = "The IP configuration of the private endpoints."
  value = tomap({
    for k, v in azurerm_private_endpoint.this : k => v.id
  })
}
