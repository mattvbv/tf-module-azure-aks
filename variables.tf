variable "region" {
  description = "Name of the Azure location (region)"  
}

variable "resource_group_name" {
 
}

variable "name" {
}

variable "worker_node_vm_size" {   
}

variable "initial_worker_node_count" {  
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

variable "fluentd_container_image" {
}

variable "fluentd_elasticsearch_host" {
}

variable "fluentd_elasticsearch_port" {
}

variable "fluentd_elasticsearch_scheme" {
}