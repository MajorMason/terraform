variable "location" {
  description = "The Azure region to deploy to"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name (dev, test or prod)"
  default     = "dev"
  type        = string
}

#Common
variable "revision_mode" {
  type = string
}
variable "container_cpu" {
  type = number
}
variable "container_memory" {
  type = string
}
variable "traffic_weight" {
  type = number
}
#CountySuite API
variable "conapp_api_port" {
  type = number
}
#Prothonotary FE
variable "conapp_prothonotary_fqdn" {
  type = string
}
variable "conapp_prothonotary_port" {
  type = number
}
#Sheriff FE
variable "conapp_sheriff_fqdn" {
  type = string
}
variable "conapp_sheriff_port" {
  type = number
}

#Output Variables
#Log Analytics
variable "log_analytics_workspace_id" {
  type = string
}
#Subnet
variable "infrastructure_subnet_id" {
  type = string
}
