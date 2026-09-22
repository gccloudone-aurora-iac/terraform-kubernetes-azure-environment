##################
### Containers ###
##################

// Scope: global
// Length: 3-24
// Valid Characters: Lowercase letters and numbers.
output "storage_account_name" {
  description = "The name of an Azure Storage Account."
  value       = local.resource_names["storage account"]
}

// Scope: storage account
// Length: 3-63
// Valid Characters: Alphanumeric
output "storage_account_container_name" {
  description = "The name of the container in a storage account"
  value       = local.resource_names["storage account container"]
}

// Scope: storage account
// Length: 3-63
// Valid Characters: Alphanumeric
output "storage_account_table_name" {
  description = "The name of the table in a storage account"
  value       = local.resource_names["storage account table"]
}

// Scope: storage account
// Length: 3-63
// Valid Characters: Alphanumeric
output "storage_account_queue_name" {
  description = "The name of the queue in a storage account"
  value       = local.resource_names["storage account queue"]
}

// Scope: storage account
// Length: 3-63
// Valid Characters: Alphanumeric
output "storage_account_file_name" {
  description = "The name of the file in a storage account"
  value       = local.resource_names["storage account file"]
}

// Scope: global
// Length: 3-24
// Valid Characters: Alphanumerics and hyphens. Start with letter. End with letter or digit. Can't contain consecutive hyphens.
output "key_vault_name" {
  description = "The name of an Azure Key Vault."
  value       = local.resource_names["key vault"]
}

// Scope: global
// Length: 5-50
// Valid Characters: Alphanumerics
output "container_registry_name" {
  description = "The name of an Azure Container Registry."
  value       = local.resource_names["container registry"]
}

// Scope: global
// Length: 3-24
// Valid characters: Alphanumeric and hyphen.
output "function_app_name" {
  description = "The name of an Function App"
  value       = local.resource_names["function app"]
}

// Scope: global
// Length: 3-24
// Valid characters: Alphanumeric.
output "data_lake_store_name" {
  description = "The name of a data lake store"
  value       = local.resource_names["data lake store"]
}


################
### Database ###
################

// Scope: global
// Length: 3-63
// Valid Characters: Lowercase letters, hyphens and numbers. Can't start or end with hyphen.
output "postgresql_server_name" {
  description = "The name of an Azure PostgreSQL Server."
  value       = local.resource_names["postgresql server"]
}
