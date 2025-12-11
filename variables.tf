#This is where we define global input variables for the entire project
#While the "type" line isn't required, its recommended to have so that others know what type
#of string the variable is
variable "location" {
  description = "The Azure region to deploy to"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name (dev, test or prod)"
  type        = string
}

#Resource Locks
variable "sql_lock" {
  description = "Type of lock placed on SQL Server resource"
  type        = string
}

#VNET
variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

#Subnet
variable "subnet_name" {
  type = string
}

variable "address_prefix" {
  type = list(string)
}

#Public IP
variable "allocation_method" {
  type = string
}

#KeyVault
variable "keyvault_name" {
  type = string
}

variable "keyvault_sku_name" {
  type = string
}

#Storage Account
variable "account_kind" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "replication_type" {
  type = string
}

#SQL Server & DBs
variable "sql_version" {
  type = string
}

variable "sql_login" {
  type = string
}

variable "sql_pass" {
  type = string
}

variable "entraid_login" {
  type = string
}

variable "object_id" {
  type = string
}

variable "license_type" {
  type = string
}

variable "max_size_gb" {
  type = number
}

variable "sql_sku_name" {
  type = string
}

variable "zone_redundant" {
  type = bool
}

#Container App & Environment
variable "revision_mode" {
  type = string
}

variable "container_name_fe" {
  type = string
}

variable "container_name_be" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_cpu" {
  type = number
}

variable "container_memory" {
  type = string
}

variable "conapp_fe_fqdn" {
  type = string
}

variable "conapp_fe_port" {
  type = number
}

variable "conapp_fe_traffic" {
  type = number
}

#Monitoring
variable "retention" {
  type = number
}
