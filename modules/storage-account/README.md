# storage-account

<!-- BEGIN_TF_DOCS -->
## 📋 Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.49.0 |

## 🔌 Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.49.0 |

## 🧩 Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_resource_names"></a> [azure\_resource\_names](#module\_azure\_resource\_names) | ../resource-names | n/a |
| <a name="module_storage_account_name"></a> [storage\_account\_name](#module\_storage\_account\_name) | ../resource-names-global | n/a |

## 🗂️ Resources

| Name | Type |
|------|------|
| [azurerm_advanced_threat_protection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key) | resource |
| [azurerm_storage_account_network_rules.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot. | `string` | `"Hot"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Replication type of the storage account. Accepted values: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS | `string` | `"LRS"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public. | `bool` | `false` | no |
| <a name="input_azure_resource_attributes"></a> [azure\_resource\_attributes](#input\_azure\_resource\_attributes) | The attributes used to name and tag the Azure resources | <pre>object({<br/>    department_code = string<br/>    owner           = string<br/>    project         = string<br/>    environment     = string<br/>    location        = optional(string, "Canada Central")<br/>    instance        = number<br/>  })</pre> | n/a | yes |
| <a name="input_containers"></a> [containers](#input\_containers) | List of containers to create | `list(string)` | `[]` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | The Azure Key Vault resource ID and key name used to manage a Customer Managed Key for a Storage Account. | <pre>object({<br/>    key_vault_id = string<br/>    key_name     = string<br/>  })</pre> | `null` | no |
| <a name="input_enable_advanced_threat_protection"></a> [enable\_advanced\_threat\_protection](#input\_enable\_advanced\_threat\_protection) | Manages the Storage Account's Advanced Threat Protection setting | `bool` | `false` | no |
| <a name="input_hns_enabled"></a> [hns\_enabled](#input\_hns\_enabled) | Enable hierarchical namespace (creates Data Lake storage account) | `bool` | `false` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | List of IP rules for accessing the Storage Account | `list(string)` | `[]` | no |
| <a name="input_naming_convention"></a> [naming\_convention](#input\_naming\_convention) | Sets which naming convention to use. Accepted values: oss, gc | `string` | `"oss"` | no |
| <a name="input_network_default_action"></a> [network\_default\_action](#input\_network\_default\_action) | The action to take when no ip\_rules or virtual\_network\_subnet\_ids match. Accepted values: Allow, Deny | `string` | `"Deny"` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | The information required to create a private endpoint for the Storage Account. | <pre>list(object({<br/>    sub_resource_name   = optional(string, "blob")<br/>    subnet_id           = string<br/>    private_dns_zone_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the public network access is enabled? Defaults to true. If var.private\_endpoints is set, this variable is automatically set to false. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group where to locate the storage account | `string` | n/a | yes |
| <a name="input_static_website"></a> [static\_website](#input\_static\_website) | Serve static content (HTML, CSS, JavaScript, and image files) directly from a storage container. | <pre>object({<br/>    index_document     = string<br/>    error_404_document = string<br/>  })</pre> | <pre>{<br/>  "error_404_document": "",<br/>  "index_document": ""<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to assign to the Azure resources | `map(string)` | `{}` | no |
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | A user-defined segment included in the name of every Azure resource. | `string` | n/a | yes |
| <a name="input_virtual_network_subnet_ids"></a> [virtual\_network\_subnet\_ids](#input\_virtual\_network\_subnet\_ids) | List of subnets to permit access to the Storage Account | `list(string)` | `[]` | no |

## 📤 Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | n/a |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | n/a |
| <a name="output_private_endpoint_ids"></a> [private\_endpoint\_ids](#output\_private\_endpoint\_ids) | The Azure resource IDs of the private endpoints created. |
| <a name="output_private_endpoint_ip_config"></a> [private\_endpoint\_ip\_config](#output\_private\_endpoint\_ip\_config) | The IP configuration of the private endpoints. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | n/a |
<!-- END_TF_DOCS -->
