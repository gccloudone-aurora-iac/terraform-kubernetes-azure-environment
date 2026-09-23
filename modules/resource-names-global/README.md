# resource-names-global

<!-- BEGIN_TF_DOCS -->
## 📋 Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, < 2.0.0 |

## 🔌 Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## 🧩 Modules

No modules.

## 🗂️ Resources

| Name | Type |
|------|------|
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_attributes"></a> [name\_attributes](#input\_name\_attributes) | name\_attributes = {<br/>      department\_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."<br/>      owner : "The name of the resource owner. OPTIONAL."<br/>      project" "The name of the project. REQUIRED"<br/>      environment : "Single character code that identifies environment. REQUIRED."<br/>      location : "Single character code that identifies Clouser\_defined\_string Service Provider and Region. REQUIRED."<br/>      instance : "The instance number of the object. OPTIONAL."<br/>    } | <pre>object({<br/>    department_code = string<br/>    owner           = string<br/>    project         = string<br/>    environment     = string<br/>    location        = string<br/>    instance        = string<br/>  })</pre> | <pre>{<br/>  "department_code": "",<br/>  "environment": "",<br/>  "instance": "",<br/>  "location": "",<br/>  "owner": "",<br/>  "project": ""<br/>}</pre> | no |
| <a name="input_naming_convention"></a> [naming\_convention](#input\_naming\_convention) | Sets which naming convention to use. Accepted values: oss, gc | `string` | `"oss"` | no |
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | A user-defined segment included in the name of every Azure resource. | `string` | n/a | yes |

## 📤 Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_name"></a> [container\_registry\_name](#output\_container\_registry\_name) | The name of an Azure Container Registry. |
| <a name="output_data_lake_store_name"></a> [data\_lake\_store\_name](#output\_data\_lake\_store\_name) | The name of a data lake store |
| <a name="output_function_app_name"></a> [function\_app\_name](#output\_function\_app\_name) | The name of an Function App |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | The name of an Azure Key Vault. |
| <a name="output_postgresql_server_name"></a> [postgresql\_server\_name](#output\_postgresql\_server\_name) | The name of an Azure PostgreSQL Server. |
| <a name="output_storage_account_container_name"></a> [storage\_account\_container\_name](#output\_storage\_account\_container\_name) | The name of the container in a storage account |
| <a name="output_storage_account_file_name"></a> [storage\_account\_file\_name](#output\_storage\_account\_file\_name) | The name of the file in a storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of an Azure Storage Account. |
| <a name="output_storage_account_queue_name"></a> [storage\_account\_queue\_name](#output\_storage\_account\_queue\_name) | The name of the queue in a storage account |
| <a name="output_storage_account_table_name"></a> [storage\_account\_table\_name](#output\_storage\_account\_table\_name) | The name of the table in a storage account |
<!-- END_TF_DOCS -->