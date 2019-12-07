resource "azurerm_kubernetes_cluster" "aksCluster" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name

  default_node_pool {
    name            = "default"
    vm_size         = var.worker_node_vm_size
    os_disk_size_gb = 30
    vnet_subnet_id  = var.subnet_id
    type            = "AvailabilitySet"
    node_count      = var.initial_worker_node_count
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  network_profile {
    network_plugin = "kubenet"
  }

  addon_profile {
    kube_dashboard {
      enabled = var.dashboard_enabled
    }
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }


}