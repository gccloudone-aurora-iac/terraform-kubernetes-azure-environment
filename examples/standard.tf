####################
### Local Values ###
####################

locals {
  azure_resource_attributes = {
    department_code = "Gc"
    owner           = "SSC"
    project         = "aur"
    environment     = "d"
    location        = "Canada Central"
    instance        = 0
  }

  azure_tags = {
    DataClassification      = "Unclassified"
    wid                     = "00001"
    Metadata                = "Undefined"
    environment             = "dev"
    PrimaryTechnicalContact = "full.name@ssc-spc.gc.ca"
    PrimaryProjectContact   = "full.name@ssc-spc.gc.ca"
  }

  cluster_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQexample== aurora-dev-cc-00"
}

#################
### Providers ###
#################

provider "azurerm" {
  features {}
}

provider "azuread" {}

data "azurerm_client_config" "this" {}

###############################
### Network (supplied here) ###
###############################

# The virtual network and its subnets are supplied to the module rather than
# created by it: `vnet_id` and `subnet_ids` are set and `subnets` is left null.
#
# They are created inline here so the example stands on its own. Where the
# network is managed elsewhere, these resources are replaced by data lookups —
# see the commented block below — with no other change to the module block.
#
# Because the network is supplied, no Azure Route Server is deployed and no
# RouteServerSubnet is required. Aurora uses managed Cilium for dataplane and
# policy, so BGP peering is not used. The module still supports a Route Server:
# let it create the network instead, via `subnets`, and pass
# `route_server_bgp_peers`.

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Canada Central"

  tags = local.azure_tags
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["172.26.0.0/23"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_servers         = ["172.20.48.4", "172.20.48.5"]

  tags = local.azure_tags
}

# The API server subnet must be delegated to AKS for VNet integration.
resource "azurerm_subnet" "apiserver" {
  name                 = "apiserver"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.26.0.0/27"]

  delegation {
    name = "aks-delegation"

    service_delegation {
      name = "Microsoft.ContainerService/managedClusters"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "infrastructure" {
  name                 = "infrastructure"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.26.0.32/27"]
}

resource "azurerm_subnet" "loadbalancer" {
  name                 = "loadbalancer"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.26.0.64/27"]
}

# One subnet per node pool. A node pool resolves its subnet by
# `vnet_subnet_name`, or by the pool's own map key when that is unset, so these
# names must match the keys of `node_pools` below.
resource "azurerm_subnet" "system" {
  name                 = "system"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.26.0.96/27"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "gateway" {
  name                 = "gateway"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.26.0.128/27"]
}

resource "azurerm_subnet" "general" {
  name                 = "general"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.26.1.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]
}

# Where the network is managed elsewhere, look it up instead of creating it:
#
# data "azurerm_virtual_network" "example" {
#   name                = "example-vnet"
#   resource_group_name = "example-network-rg"
# }
#
# data "azurerm_subnet" "this" {
#   for_each = toset(["apiserver", "infrastructure", "loadbalancer", "system", "gateway", "general"])
#
#   name                 = each.key
#   virtual_network_name = data.azurerm_virtual_network.example.name
#   resource_group_name  = data.azurerm_virtual_network.example.resource_group_name
# }

#################
### DNS Zones ###
#################

# In a real environment these zones already exist and are looked up with data
# sources. They are created here so the example stands on its own.

resource "azurerm_private_dns_zone" "aks_api_server" {
  name                = "privatelink.canadacentral.azmk8s.io"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone" "blob_storage" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.example.name
}

# cert-manager solves DNS-01 challenges against a PUBLIC zone, not a private one.
resource "azurerm_dns_zone" "cert_manager" {
  name                = "example.ca"
  resource_group_name = azurerm_resource_group.example.name
}

################
### Entra ID ###
################

resource "azuread_group" "aurora_general_cluster_user" {
  display_name     = "aurora-general-cluster-user"
  owners           = [data.azurerm_client_config.this.object_id]
  security_enabled = true
}

#################################
### Aurora Environment Module ###
#################################

# Manages the Aurora Environment.
#
module "aurora" {
  source = "../"

  azure_resource_attributes = local.azure_resource_attributes

  naming_convention = "gc"
  user_defined      = "AKS"

  ingress_host = "example.ca"

  # A base64-encoded CA certificate bundle to trust on every node. Leave null
  # when the environment does not sit behind a TLS-inspecting proxy.
  custom_ca_trust_certificates_base64 = null

  ###############
  ### Network ###
  ###############

  # The network is supplied, so `subnets` is null and the module does not create
  # a virtual network, route table, NSGs or Route Server.
  vnet_id            = azurerm_virtual_network.example.id
  vnet_address_space = azurerm_virtual_network.example.address_space
  subnets            = null

  subnet_ids = {
    apiserver      = azurerm_subnet.apiserver.id
    infrastructure = azurerm_subnet.infrastructure.id
    loadbalancer   = azurerm_subnet.loadbalancer.id
    system         = azurerm_subnet.system.id
    gateway        = azurerm_subnet.gateway.id
    general        = azurerm_subnet.general.id
  }

  vnet_integration_enabled = true

  # No Route Server: Aurora uses managed Cilium, so there are no BGP peers and
  # no next hop for the module to program. Both remain supported.
  route_server_bgp_peers          = null
  route_table_next_hop_ip_address = null

  ###########
  ### AKS ###
  ###########

  kubernetes_version      = "1.35.1"
  node_os_upgrade_channel = "None"
  cluster_sku_tier        = "Premium"
  cluster_support_plan    = "KubernetesOfficial"

  # Managed Cilium for both network policy and dataplane.
  network_plugin     = "azure"
  network_mode       = null
  network_policy     = "cilium"
  network_data_plane = "cilium"

  cluster_linux_profile_ssh_key = local.cluster_ssh_key

  spn_object_ids = [data.azurerm_client_config.this.object_id]

  # Members of the generated cluster-admins Entra ID group. Set
  # cluster_admins_group_object_id instead to reuse an existing group.
  cluster_admins                 = [data.azurerm_client_config.this.object_id]
  cluster_admins_group_object_id = null

  node_pools = {
    system = {
      mode               = "System"
      availability_zones = [1]
      vm_size            = "Standard_D4s_v5"
      max_pods           = 60
      os_sku             = "AzureLinux"

      enable_auto_scaling    = true
      auto_scaling_min_nodes = 1
      auto_scaling_max_nodes = 4

      node_taints = ["CriticalAddonsOnly=true:NoSchedule"]
      node_labels = {
        "node.ssc-spc.gc.ca/use"     = "general"
        "node.ssc-spc.gc.ca/purpose" = "system"
      }
    }

    general = {
      availability_zones = [1]
      vm_size            = "Standard_D8s_v5"
      max_pods           = 62
      os_sku             = "AzureLinux"

      enable_auto_scaling    = true
      auto_scaling_min_nodes = 1
      auto_scaling_max_nodes = 3

      node_labels = {
        "node.ssc-spc.gc.ca/use"     = "general"
        "node.ssc-spc.gc.ca/purpose" = "general"
      }
    }

    gateway = {
      availability_zones = [1]
      vm_size            = "Standard_D4s_v5"
      max_pods           = 30
      os_sku             = "AzureLinux"

      enable_auto_scaling    = true
      auto_scaling_min_nodes = 1
      auto_scaling_max_nodes = 3

      node_taints = ["node.ssc-spc.gc.ca/purpose=gateway:NoSchedule"]
      node_labels = {
        "node.ssc-spc.gc.ca/use"     = "general"
        "node.ssc-spc.gc.ca/purpose" = "gateway"
      }
    }
  }

  azure_policy_enabled = false

  ###############################
  ### Platform Infrastructure ###
  ###############################

  grafana_sp = {
    members = {
      admin  = {}
      editor = {}
      viewer = {
        aurora_general_cluster_user = azuread_group.aurora_general_cluster_user.object_id
      }
    }
  }

  service_principal_owners = [data.azurerm_client_config.this.object_id]

  create_private_dns_zone_role  = true
  create_custom_role_assignment = true

  ####################
  ### Data Sources ###
  ####################

  data_sources = {
    dns_zone_id = {
      azmk8s       = azurerm_private_dns_zone.aks_api_server.id
      cert_manager = azurerm_dns_zone.cert_manager.id
      blob_storage = azurerm_private_dns_zone.blob_storage.id
      keyvault     = azurerm_private_dns_zone.keyvault.id
    }
    active_directory = {
      service_principal_id = {
        cicd_runner           = data.azurerm_client_config.this.client_id
        cluster_admins_owners = [data.azurerm_client_config.this.object_id]
      }
      group_id = {
        aurora_general_cluster_user = azuread_group.aurora_general_cluster_user.object_id
      }
      tenant_id       = data.azurerm_client_config.this.tenant_id
      subscription_id = data.azurerm_client_config.this.subscription_id
    }
  }

  tags = local.azure_tags
}
