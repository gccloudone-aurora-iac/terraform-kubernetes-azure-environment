# kubernetes-cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.49.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.49.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_resource_names"></a> [azure\_resource\_names](#module\_azure\_resource\_names) | git::https://github.com/gccloudone-aurora-iac/terraform-aurora-azure-resource-names.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [random_password.windows_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_pet.linux_username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.windows_username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | A list of Azure AAD group object IDs that will receive administrative access to the cluster | `list(string)` | `[]` | no |
| <a name="input_api_server"></a> [api\_server](#input\_api\_server) | Configuration for the cluster's API server. | <pre>object({<br/>    authorized_ip_ranges     = optional(list(string))<br/>    subnet_id                = optional(string)<br/>    vnet_integration_enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_auto_scaler_profile"></a> [auto\_scaler\_profile](#input\_auto\_scaler\_profile) | The configuration details for the cluster's auto scaler profile. | <pre>object({<br/>    expander      = optional(string, "random")<br/>    scan_interval = optional(string, "10s")<br/><br/>    new_pod_scale_up_delay = optional(string, "0s")<br/><br/>    scale_down_utilization_threshold = optional(number, 0.5)<br/>    scale_down_delay_after_add       = optional(string, "10m")<br/>    scale_down_delay_after_delete    = optional(string) # defaults to scan_interval<br/>    scale_down_delay_after_failure   = optional(string, "3m")<br/>    scale_down_unneeded              = optional(string, "10m")<br/>    scale_down_unready               = optional(string, "20m")<br/><br/>    max_graceful_termination_sec = optional(number, 600)<br/>    max_node_provisioning_time   = optional(string, "15m")<br/>    max_unready_nodes            = optional(number, 3)<br/>    max_unready_percentage       = optional(number, 45)<br/><br/>    skip_nodes_with_local_storage = optional(bool, false)<br/>    skip_nodes_with_system_pods   = optional(bool, true)<br/>    balance_similar_node_groups   = optional(bool, false)<br/>    empty_bulk_delete_max         = optional(number, 10)<br/>  })</pre> | `null` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | Automatically perform upgrades of the Kubernetes cluster (none, patch, rapid, stable) | `string` | `"none"` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | Enable the Azure Policy add-on for the cluster | `bool` | `false` | no |
| <a name="input_azure_resource_attributes"></a> [azure\_resource\_attributes](#input\_azure\_resource\_attributes) | The attributes used to name and tag the Azure resources | <pre>object({<br/>    department_code = string<br/>    owner           = string<br/>    project         = string<br/>    environment     = string<br/>    location        = optional(string, "Canada Central")<br/>    instance        = number<br/>  })</pre> | n/a | yes |
| <a name="input_custom_ca_trust_certificates_base64"></a> [custom\_ca\_trust\_certificates\_base64](#input\_custom\_ca\_trust\_certificates\_base64) | The base64-encoded CA certificates to trust on the cluster nodes | `list(string)` | `null` | no |
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | The configuration details of the cluster's default node pool. | <pre>object({<br/>    name                 = optional(string, "system")<br/>    vnet_subnet_id       = string<br/>    pod_subnet_id        = optional(string, null)<br/>    vm_size              = optional(string, "Standard_D2s_v3")<br/>    kubernetes_version   = optional(string, null)<br/>    os_sku               = optional(string, "Ubuntu")<br/>    availability_zones   = optional(list(string), null)<br/>    node_labels          = optional(map(string), {})<br/>    node_taints          = optional(list(string), [])<br/>    only_critical_addons = optional(bool, true) # Only run critical workloads (AKS managed) on the node pool when enabled<br/><br/>    node_count             = optional(number, 3) # Only used if enable_auto_scaling is set to false<br/>    enable_auto_scaling    = optional(bool, false)<br/>    auto_scaling_min_nodes = optional(number, 3) # Only used if enable_auto_scaling = true<br/>    auto_scaling_max_nodes = optional(number, 5) # Only used if enable_auto_scaling = true<br/>    max_pods               = optional(number, 60)<br/><br/>    upgrade_settings = optional(object({<br/>      max_surge                     = optional(string, "33%")<br/>      drain_timeout_in_minutes      = optional(number, 30)<br/>      node_soak_duration_in_minutes = optional(number, 0)<br/>      }), {<br/>      max_surge                     = "33%"<br/>      drain_timeout_in_minutes      = 30<br/>      node_soak_duration_in_minutes = 0<br/>    })<br/><br/>    enable_host_encryption = optional(bool, false)<br/>    os_disk_size_gb        = optional(number, 256)<br/>    os_disk_type           = optional(string, "managed")<br/>  })</pre> | n/a | yes |
| <a name="input_diag_setting"></a> [diag\_setting](#input\_diag\_setting) | n/a | <pre>map(object({<br/>    log_analytics_workspace_id     = optional(string)<br/>    log_analytics_destination_type = optional(string)<br/>    storage_account_id             = optional(string)<br/>    enabled_log_categories         = optional(list(string), ["kube-apiserver", "kube-controller-manager", "cluster-autoscaler"])<br/>    enable_all_metrics             = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | Used to encrypt the cluster's Nodes and Volumes with Customer Managed Keys. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix specified when creating the managed cluster. Possible values must begin and end with a letter or number, contain only letters, numbers, and hyphens and be between 1 and 54 characters in length. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_dns_prefix_private_cluster"></a> [dns\_prefix\_private\_cluster](#input\_dns\_prefix\_private\_cluster) | Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created. | `string` | `"10.0.0.10"` | no |
| <a name="input_kubelet_identity"></a> [kubelet\_identity](#input\_kubelet\_identity) | The user-defined Managed Identity assigned to the Kubelets | <pre>object({<br/>    client_id                 = string<br/>    object_id                 = string<br/>    user_assigned_identity_id = string<br/>  })</pre> | <pre>{<br/>  "client_id": null,<br/>  "object_id": null,<br/>  "user_assigned_identity_id": null<br/>}</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes specified when creating the AKS managed cluster | `string` | `"1.17.16"` | no |
| <a name="input_linux_profile_public_ssh_key"></a> [linux\_profile\_public\_ssh\_key](#input\_linux\_profile\_public\_ssh\_key) | The SSH public key used to connect to the cluster's Linux nodes. Changing this will update the key on all node pools. If the value is null, this module will autogenerate an SSH key to use. | `string` | `null` | no |
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | The load balancer configuration arguments. The profile can't be enabled if var.outbound\_type userDefinedRouting. Refer to https://learn.microsoft.com/en-us/azure/aks/egress-outboundtype for more details. | <pre>object({<br/>    sku                                 = optional(string, "standard")<br/>    profile_enabled                     = optional(bool, true)<br/>    profile_idle_timeout_in_minutes     = optional(number, 30)<br/>    profile_managed_outbound_ip_count   = optional(number)<br/>    profile_managed_outbound_ipv6_count = optional(number)<br/>    profile_outbound_ip_address_ids     = optional(set(string))<br/>    profile_outbound_ip_prefix_ids      = optional(set(string))<br/>    profile_outbound_ports_allocated    = optional(number, 0)<br/><br/>  })</pre> | <pre>{<br/>  "profile_enabled": false<br/>}</pre> | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | If true local accounts will be disabled. See the documentation https://learn.microsoft.com/en-us/azure/aks/managed-aad#disable-local-accounts for more information. | `bool` | `true` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The maintenance window for the cluster. Refer to https://learn.microsoft.com/en-us/azure/aks/planned-maintenance for more information. | <pre>object({<br/>    allowed = optional(list(object({<br/>      day   = string      # Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday<br/>      hours = set(number) # An array of hour slots in a day<br/>    }))),<br/>    not_allowed = optional(list(object({<br/>      end   = string<br/>      start = string<br/>    }))),<br/>  })</pre> | `null` | no |
| <a name="input_maintenance_window_node_os"></a> [maintenance\_window\_node\_os](#input\_maintenance\_window\_node\_os) | The maintenance window for the node OS upgrades. Refer to https://learn.microsoft.com/en-us/azure/aks/planned-maintenance for more information. | <pre>object({<br/>    frequency    = string # Daily, Weekly, AbsoluteMonthly or RelativeMonthly<br/>    interval     = number<br/>    day_of_week  = optional(string) # Friday, Monday, Saturday, Sunday, Thursday, Tuesday or Wednesday<br/>    day_of_month = optional(number) # Value between 0 and 31 (inclusive)<br/>    week_index   = optional(string) # First, Second, Third, Fourth, or Last<br/><br/>    start_time = optional(string) #  Format is HH:mm<br/>    utc_offset = optional(string)<br/>    duration   = string # The duration of the window for maintenance to run in hours<br/><br/>    not_allowed = optional(list(object({<br/>      end   = string<br/>      start = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_naming_convention"></a> [naming\_convention](#input\_naming\_convention) | Sets which naming convention to use. Accepted values: oss, gc | `string` | `"oss"` | no |
| <a name="input_network_data_plane"></a> [network\_data\_plane](#input\_network\_data\_plane) | AKS network data plane. Accepted values: azure, cilium, null | `string` | `"cilium"` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | AKS network mode. Accepted values: bridge, transparent, null | `string` | `"transparent"` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | AKS network plugin. Accepted values: azure, none | `string` | `"azure"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | AKS network policy. Accepted values: azure, cilium, null | `string` | `"cilium"` | no |
| <a name="input_node_os_channel_upgrade"></a> [node\_os\_channel\_upgrade](#input\_node\_os\_channel\_upgrade) | The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are Unmanaged, SecurityPatch, NodeImage and None. | `string` | `null` | no |
| <a name="input_node_resource_group_name"></a> [node\_resource\_group\_name](#input\_node\_resource\_group\_name) | Name of the Resource Group where the Kubernetes Nodes should exist | `any` | `null` | no |
| <a name="input_oidc_issuer"></a> [oidc\_issuer](#input\_oidc\_issuer) | Enable or Disable the OIDC issuer URL and specifies whether Azure AD Workload Identity should be enabled for the Cluster | <pre>object({<br/>    enabled                   = bool<br/>    workload_identity_enabled = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "enabled": true,<br/>  "workload_identity_enabled": true<br/>}</pre> | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. | `string` | `"userDefinedRouting"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Deploy a private cluster control plane. Requires private link + private DNS support. The api\_server\_authorized\_ip\_ranges option is disabled when private cluster is enabled. | `bool` | `false` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Private DNS zone id for use by private clusters. If unset, and a private cluster is requested, the DNS zone will be created and managed by AKS | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group where the Managed Kubernetes Cluster should exist | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | SKU Tier of the cluster ("Standard" is preferred). The SKU determines the cluster's uptime SLA. Refer to https://learn.microsoft.com/en-us/azure/aks/uptime-sla for more information. | `string` | `"Standard"` | no |
| <a name="input_storage_profile"></a> [storage\_profile](#input\_storage\_profile) | The Storage Profile object to be used for the AKS Cluster | <pre>object({<br/>    blob_driver_enabled         = bool<br/>    disk_driver_enabled         = bool<br/>    disk_driver_version         = string<br/>    file_driver_enabled         = bool<br/>    snapshot_controller_enabled = bool<br/>  })</pre> | <pre>{<br/>  "blob_driver_enabled": false,<br/>  "disk_driver_enabled": true,<br/>  "disk_driver_version": "v1",<br/>  "file_driver_enabled": true,<br/>  "snapshot_controller_enabled": true<br/>}</pre> | no |
| <a name="input_support_plan"></a> [support\_plan](#input\_support\_plan) | Specifies the support plan which should be used for this Kubernetes Cluster. Possible values are KubernetesOfficial and AKSLongTermSupport. Defaults to KubernetesOfficial | `string` | `"KubernetesOfficial"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to assign to the Azure resources | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity_ids"></a> [user\_assigned\_identity\_ids](#input\_user\_assigned\_identity\_ids) | User Assigned Identity IDs for use by the cluster control plane | `list(string)` | n/a | yes |
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | A user-defined segment included in the name of every Azure resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_kubeconfig"></a> [admin\_kubeconfig](#output\_admin\_kubeconfig) | A Terraform object that contain kubeconfig info. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the Azure Kubernetes Managed Cluster. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | A Terraform object that contains kubeconfig info. |
| <a name="output_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#output\_kubernetes\_cluster\_id) | The Kubernetes Managed Cluster ID. |
| <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name) | The name of the AKS cluster. |
| <a name="output_kubernetes_identity"></a> [kubernetes\_identity](#output\_kubernetes\_identity) | The managed service identity assigned to the Kubernetes cluster |
| <a name="output_kubernetes_kubelet_identity"></a> [kubernetes\_kubelet\_identity](#output\_kubernetes\_kubelet\_identity) | The user-defined Managed Identity assigned to the Kubelets. |
| <a name="output_linux_generated_private_ssh_key"></a> [linux\_generated\_private\_ssh\_key](#output\_linux\_generated\_private\_ssh\_key) | The cluster will use this generated private key when `var.linux_profile_public_ssh_key` is null. Private key data in [PEM (RFC 1421)](https://datatracker.ietf.org/doc/html/rfc1421) format. |
| <a name="output_linux_generated_public_ssh_key"></a> [linux\_generated\_public\_ssh\_key](#output\_linux\_generated\_public\_ssh\_key) | The cluster will use this generated public key as ssh key when `var.linux_profile_public_ssh_key` is empty or null. |
| <a name="output_linux_username"></a> [linux\_username](#output\_linux\_username) | The Admin Username for the Cluster. |
| <a name="output_node_resource_group_id"></a> [node\_resource\_group\_id](#output\_node\_resource\_group\_id) | The ID of the Resource Group containing the resources for this Managed Kubernetes Cluster. |
| <a name="output_node_resource_group_name"></a> [node\_resource\_group\_name](#output\_node\_resource\_group\_name) | The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster. |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | The OIDC issuer URL that is associated with the cluster. |
| <a name="output_windows_password"></a> [windows\_password](#output\_windows\_password) | The Admin Password for Windows VMs. |
| <a name="output_windows_username"></a> [windows\_username](#output\_windows\_username) | The Admin Username for Windows VMs. |
<!-- END_TF_DOCS -->
