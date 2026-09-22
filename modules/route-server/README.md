# route-server

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.49.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.49.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_resource_names"></a> [azure\_resource\_names](#module\_azure\_resource\_names) | git::https://github.com/gccloudone-aurora-iac/terraform-aurora-azure-resource-names.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_route_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_server) | resource |
| [azurerm_route_server_bgp_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_server_bgp_connection) | resource |
| [azurerm_virtual_hub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_hub) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_resource_attributes"></a> [azure\_resource\_attributes](#input\_azure\_resource\_attributes) | The attributes used to name and tag the Azure resources | <pre>object({<br/>    department_code = string<br/>    owner           = string<br/>    project         = string<br/>    environment     = string<br/>    location        = optional(string, "Canada Central")<br/>    instance        = number<br/>  })</pre> | n/a | yes |
| <a name="input_bgp_peers"></a> [bgp\_peers](#input\_bgp\_peers) | The details for creating a BGP connection within the route server. | <pre>list(object({<br/>    name     = string<br/>    peer_asn = number<br/>    peer_ip  = string<br/>  }))</pre> | n/a | yes |
| <a name="input_branch_to_branch_traffic_enabled"></a> [branch\_to\_branch\_traffic\_enabled](#input\_branch\_to\_branch\_traffic\_enabled) | Whether to enable route exchange between Azure Route Server and the gateway(s). | `bool` | `false` | no |
| <a name="input_naming_convention"></a> [naming\_convention](#input\_naming\_convention) | Sets which naming convention to use. Accepted values: oss, gc | `string` | `"oss"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group to be used for the route server. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the route server. | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet that the Route Server will reside. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to assign to the route server and its public IP | `map(string)` | `{}` | no |
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | A user-defined segment included in the name of every Azure resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asn"></a> [asn](#output\_asn) | The Autonomous System Number of the Virtual Hub BGP router. |
| <a name="output_bgp_peers"></a> [bgp\_peers](#output\_bgp\_peers) | The ids of the BGP peers |
| <a name="output_id"></a> [id](#output\_id) | The id of the Route Server |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The IP address of the public IP used by the route server |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The id of the public IP used by the route server |
| <a name="output_route_server_ip_addresses"></a> [route\_server\_ip\_addresses](#output\_route\_server\_ip\_addresses) | The peer IP addresses of the Route Server. In other words, it is the private IPs of the route server. |
<!-- END_TF_DOCS -->
