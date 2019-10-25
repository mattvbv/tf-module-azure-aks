resource "azurerm_kubernetes_cluster" "aksCluster" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name

  agent_pool_profile {
    name            = "${var.name}p0"
    count           = "${var.worker_count}"
    vm_size         = var.worker_vm_size
    os_type         = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id  = var.subnet_id
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }


}