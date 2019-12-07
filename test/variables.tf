variable "region" {
  default = "West Europe"
}

variable "resource_group_name" {
  default = "mviac-platform-tests-tf-module-aks"
}

variable "vnet_name" {
  default = "mviac-platform-tests-tests-tf-module-network-vnet"
}

variable "name" {
  default = "pftestsaks"
}

variable "subnet_resource_group_name" {
  default = "mviac-platform-tests-tf-module-network"
}

variable "subnet_name" {
  default = "platformtestsubnet"
}

variable "worker_node_vm_size" { 
  default = "Standard_B2ms"
}

variable "initial_worker_node_count" {
  default = "1"
}

variable "service_principal_client_id" {
}

variable "service_principal_client_secret" {
}

variable "dashboard_enabled" {
  default = true
}

variable "fluentd_container_image" {
  default = "fluent/fluentd-kubernetes-daemonset:v1.3-debian-elasticsearch-1"
}

variable "fluentd_elasticsearch_host" {
  default = "elk"
}

variable "fluentd_elasticsearch_port" {
  default = "9200"
}

variable "fluentd_elasticsearch_scheme" {
  default = "http"
}
