provider "azurerm" {
  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
  }
}

data "azurerm_subnet" "theSubnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.subnet_resource_group_name
}

module "aks" {
  source  = "../"
  region = var.region
  resource_group_name = var.resource_group_name
  name = var.name
  worker_vm_size = var.worker_vm_size
  worker_count = var.worker_count
  subnet_id = "${data.azurerm_subnet.theSubnet.id}"
  service_principal_client_id = var.service_principal_client_id
  service_principal_client_secret = var.service_principal_client_secret
  fluentd_container_image = var.fluentd_container_image
  fluentd_elasticsearch_host = var.fluentd_elasticsearch_host
  fluentd_elasticsearch_port = var.fluentd_elasticsearch_port
  fluentd_elasticsearch_scheme = var.fluentd_elasticsearch_scheme  
}
