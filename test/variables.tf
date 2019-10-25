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

variable "worker_vm_size" { 
  default = "Standard_B2ms"
}

variable "worker_count" {
  default = "1"
}

variable "service_principal_client_id" {
}

variable "service_principal_client_secret" {
}
