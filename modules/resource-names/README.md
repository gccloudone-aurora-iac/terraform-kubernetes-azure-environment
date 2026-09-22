# resource-names

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, < 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_attributes"></a> [name\_attributes](#input\_name\_attributes) | name\_attributes = {<br/>      department\_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."<br/>      owner : "The name of the resource owner. OPTIONAL."<br/>      project" "The name of the project. REQUIRED"<br/>      environment : "Single character code that identifies environment. REQUIRED."<br/>      location : "Single character code that identifies Cloud Service Provider and Region. REQUIRED."<br/>      instance : "The instance number of the object. OPTIONAL."<br/>    } | <pre>object({<br/>    department_code = string<br/>    owner           = string<br/>    project         = string<br/>    environment     = string<br/>    location        = string<br/>    instance        = string<br/>  })</pre> | <pre>{<br/>  "department_code": "",<br/>  "environment": "",<br/>  "instance": "",<br/>  "location": "",<br/>  "owner": "",<br/>  "project": ""<br/>}</pre> | no |
| <a name="input_naming_convention"></a> [naming\_convention](#input\_naming\_convention) | Sets which naming convention to use. Accepted values: oss, gc | `string` | `"oss"` | no |
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | A user-defined segment included in the name of every Azure resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_active_directory_group_name"></a> [active\_directory\_group\_name](#output\_active\_directory\_group\_name) | The name of an Azure Active Directory Group. |
| <a name="output_application_security_group_name"></a> [application\_security\_group\_name](#output\_application\_security\_group\_name) | The name of an Azure Application Security Group. |
| <a name="output_availability_set_name"></a> [availability\_set\_name](#output\_availability\_set\_name) | The name of an availability set |
| <a name="output_azure_application_gateway_name"></a> [azure\_application\_gateway\_name](#output\_azure\_application\_gateway\_name) | The name of an azure application gateway |
| <a name="output_azure_databricks_name"></a> [azure\_databricks\_name](#output\_azure\_databricks\_name) | The name of an azure data brick service |
| <a name="output_bastion_end_point_name"></a> [bastion\_end\_point\_name](#output\_bastion\_end\_point\_name) | The name of an Azure Bastion End-point |
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | The name of a connection for a virtual network |
| <a name="output_disk_encryption_set_name"></a> [disk\_encryption\_set\_name](#output\_disk\_encryption\_set\_name) | The name of an Azure Disk Encryption Set. |
| <a name="output_firewall_name"></a> [firewall\_name](#output\_firewall\_name) | The name of an Azure Firewall. |
| <a name="output_key_vault_secret_name"></a> [key\_vault\_secret\_name](#output\_key\_vault\_secret\_name) | The name of an Secret in Azure Key Vault. |
| <a name="output_kubernetes_service_name"></a> [kubernetes\_service\_name](#output\_kubernetes\_service\_name) | The name of an Azure Kubernetes Service. |
| <a name="output_load_balancer_backend_pool_name"></a> [load\_balancer\_backend\_pool\_name](#output\_load\_balancer\_backend\_pool\_name) | The name of a load balancer backend pool |
| <a name="output_load_balancer_front_end_interface_name"></a> [load\_balancer\_front\_end\_interface\_name](#output\_load\_balancer\_front\_end\_interface\_name) | The name of a load balancer front end interface |
| <a name="output_load_balancer_health_probe_name"></a> [load\_balancer\_health\_probe\_name](#output\_load\_balancer\_health\_probe\_name) | The name of a load balancer health probe |
| <a name="output_load_balancer_name"></a> [load\_balancer\_name](#output\_load\_balancer\_name) | The name of an Azure Load Balancer. |
| <a name="output_load_balancer_rules_name"></a> [load\_balancer\_rules\_name](#output\_load\_balancer\_rules\_name) | The name of a load balancer rule |
| <a name="output_local_network_gateway_name"></a> [local\_network\_gateway\_name](#output\_local\_network\_gateway\_name) | The name of a virtual network gateway |
| <a name="output_managed_identity_name"></a> [managed\_identity\_name](#output\_managed\_identity\_name) | The name of an Azure User-Assigned Managed Identity. |
| <a name="output_management_group_name"></a> [management\_group\_name](#output\_management\_group\_name) | The name of an Azure Resource Group. |
| <a name="output_name"></a> [name](#output\_name) | The common prefix for an Azure resource name. Under typical circumstances, the resource type acronym would just be appended to complete the resource name. |
| <a name="output_network_interface_card_name"></a> [network\_interface\_card\_name](#output\_network\_interface\_card\_name) | The name of a Network Interface Card. |
| <a name="output_network_security_group_name"></a> [network\_security\_group\_name](#output\_network\_security\_group\_name) | The name of an Azure Network Security Group. |
| <a name="output_network_security_group_rule_name"></a> [network\_security\_group\_rule\_name](#output\_network\_security\_group\_rule\_name) | The name of a network security group rule. |
| <a name="output_private_endpoint_name"></a> [private\_endpoint\_name](#output\_private\_endpoint\_name) | The name of an Azure Private Endpoint. |
| <a name="output_public_ip_address_name"></a> [public\_ip\_address\_name](#output\_public\_ip\_address\_name) | The name of a Public IP Address in Azure. |
| <a name="output_public_ip_address_route_server_name"></a> [public\_ip\_address\_route\_server\_name](#output\_public\_ip\_address\_route\_server\_name) | The name of a Public IP Address in Azure. |
| <a name="output_resource_group_backup_name"></a> [resource\_group\_backup\_name](#output\_resource\_group\_backup\_name) | The name of an Azure Resource Group for Backups. |
| <a name="output_resource_group_kubernetes_service_name"></a> [resource\_group\_kubernetes\_service\_name](#output\_resource\_group\_kubernetes\_service\_name) | The name of an Azure Resource Group for the Kubernetes Service. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of an Azure Resource Group. |
| <a name="output_resource_group_platform_name"></a> [resource\_group\_platform\_name](#output\_resource\_group\_platform\_name) | The name of an Azure Resource Group for Platform. |
| <a name="output_resource_group_secrets_name"></a> [resource\_group\_secrets\_name](#output\_resource\_group\_secrets\_name) | The name of an Azure Resource Group for Secrets. |
| <a name="output_route_name"></a> [route\_name](#output\_route\_name) | The name of a route for a route. |
| <a name="output_route_server_name"></a> [route\_server\_name](#output\_route\_server\_name) | The name of an Azure Route Server. |
| <a name="output_route_table_name"></a> [route\_table\_name](#output\_route\_table\_name) | The name of an Azure Route Table. |
| <a name="output_service_endpoint_policy_name"></a> [service\_endpoint\_policy\_name](#output\_service\_endpoint\_policy\_name) | The name of an Azure Service Endpoint Policy. |
| <a name="output_service_principal_name"></a> [service\_principal\_name](#output\_service\_principal\_name) | The name of an Azure Service Principal. |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The name of a subnet for a virtual network |
| <a name="output_subscription_name"></a> [subscription\_name](#output\_subscription\_name) | The name of an Azure Resource Group. |
| <a name="output_traffic_manager_profile_name"></a> [traffic\_manager\_profile\_name](#output\_traffic\_manager\_profile\_name) | The name of a traffic manager profile |
| <a name="output_virtual_machine_data_disk_name"></a> [virtual\_machine\_data\_disk\_name](#output\_virtual\_machine\_data\_disk\_name) | The name of a managed disk for an OS disk for a virtual machine |
| <a name="output_virtual_machine_name"></a> [virtual\_machine\_name](#output\_virtual\_machine\_name) | The name of an Azure Virtual Machine |
| <a name="output_virtual_machine_os_disk_name"></a> [virtual\_machine\_os\_disk\_name](#output\_virtual\_machine\_os\_disk\_name) | The name of a managed disk for an OS disk for a virtual machine |
| <a name="output_virtual_machine_scale_set_name"></a> [virtual\_machine\_scale\_set\_name](#output\_virtual\_machine\_scale\_set\_name) | The name of a Virtual Machine Scale Set (VMSS) |
| <a name="output_virtual_network_gateway_name"></a> [virtual\_network\_gateway\_name](#output\_virtual\_network\_gateway\_name) | The name of a virtual network gateway |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of an Azure Virtual Network. |
<!-- END_TF_DOCS -->