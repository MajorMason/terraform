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

#Shared
variable "revision_mode" {
  type = string
}
variable "container_cpu" {
  type = number
}
variable "container_memory" {
  type = string
}
#CountySuite API
variable "conapp_api_port" {
  type = number
}
variable "conapp_api_traffic" {
  type = number
}
#Prothonotary FE
variable "conapp_prothonotary_fqdn" {
  type = string
}
variable "conapp_prothonotary_port" {
  type = number
}
variable "conapp_prothonotary_traffic" {
  type = number
}
#Sheriff FE
variable "conapp_sheriff_fqdn" {
  type = string
}
variable "conapp_sheriff_port" {
  type = number
}
variable "conapp_sheriff_traffic" {
  type = number
}
