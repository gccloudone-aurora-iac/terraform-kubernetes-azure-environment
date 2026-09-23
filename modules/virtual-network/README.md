# virtual-network

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

## 🗂️ Resources

| Name | Type |
|------|------|
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_service_endpoint_storage_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_service_endpoint_storage_policy) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.origin_to_remote](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network. | `list(string)` | n/a | yes |
| <a name="input_azure_resource_attributes"></a> [azure\_resource\_attributes](#input\_azure\_resource\_attributes) | The attributes used to name and tag the Azure resources | <pre>object({<br/>    department_code = string<br/>    owner           = string<br/>    project         = string<br/>    environment     = string<br/>    location        = optional(string, "Canada Central")<br/>    instance        = number<br/>  })</pre> | n/a | yes |
| <a name="input_ddos_protection_plan_id"></a> [ddos\_protection\_plan\_id](#input\_ddos\_protection\_plan\_id) | The DDoS protection plan resource ID | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | The DNS servers to be used with VNet. If no values specified, this defaults to Azure DNS. | `list(string)` | `[]` | no |
| <a name="input_naming_convention"></a> [naming\_convention](#input\_naming\_convention) | Sets which naming convention to use. Accepted values: oss, gc | `string` | `"oss"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group to create the virtual network in. | `string` | n/a | yes |
| <a name="input_subnet_nsgs"></a> [subnet\_nsgs](#input\_subnet\_nsgs) | n/a | <pre>list(object({<br/>    subnet_name = string<br/>    nsg_id      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_subnet_route_tables"></a> [subnet\_route\_tables](#input\_subnet\_route\_tables) | n/a | <pre>list(object({<br/>    subnet_name    = string<br/>    route_table_id = string<br/>  }))</pre> | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The subnets created within the VNet | <pre>list(object({<br/>    name             = string<br/>    address_prefixes = list(string)<br/><br/>    nsg_id         = optional(string)<br/>    route_table_id = optional(string)<br/><br/>    service_endpoints = optional(list(string))<br/>    service_endpoint_policy_definitions = optional(list(object({ # No policy is created if unspecified<br/>      name        = optional(string)<br/>      description = optional(string)<br/>      service     = optional(string, "Microsoft.Storage")<br/>      scopes      = list(string)<br/>    })))<br/><br/>    service_delegation_name                       = optional(string) # The name of service to delegate to<br/>    private_endpoint_network_policies_enabled     = optional(string, "Enabled")<br/>    private_link_service_network_policies_enabled = optional(bool, true)<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to associate with your network and subnets. | `map(string)` | `{}` | no |
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | A user-defined segment included in the name of every Azure resource. | `string` | n/a | yes |
| <a name="input_vnet_peers"></a> [vnet\_peers](#input\_vnet\_peers) | A list of remote virtual network resource IDs to use as virtual network peerings. | `list(string)` | `[]` | no |

## 📤 Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | The address space of the VNet |
| <a name="output_id"></a> [id](#output\_id) | The id of the VNet |
| <a name="output_location"></a> [location](#output\_location) | The location of the VNet |
| <a name="output_name"></a> [name](#output\_name) | The name of the VNet |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group used by the Virtual Network. |
| <a name="output_vnet_peering_origin_to_remote_ids"></a> [vnet\_peering\_origin\_to\_remote\_ids](#output\_vnet\_peering\_origin\_to\_remote\_ids) | The IDs of the Virtual Network Peering. |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets) | The ids of subnets created inside the VNet |
| <a name="output_vnet_subnets_name_id"></a> [vnet\_subnets\_name\_id](#output\_vnet\_subnets\_name\_id) | Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet\_subnets\_name\_id, subnet1) |
<!-- END_TF_DOCS -->
