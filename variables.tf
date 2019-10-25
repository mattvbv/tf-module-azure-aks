variable "region" {
  description = "Name of the Azure location (region)"  
}

variable "resource_group_name" {
 
}

variable "name" {
}

variable "worker_vm_size" {   
}

variable "worker_count" {  
}

variable "subnet_id" {
   
}

variable "service_principal_client_id" {
}

variable "service_principal_client_secret" {
}

variable "rbac_enabled" {
  default = true
}