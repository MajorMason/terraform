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
variable "address_space_monitor" {
  type = list(string)
}

#Subnet
variable "subnet_name" {
  type = string
}
variable "private_address_prefix" {
  type = list(string)
}
variable "private_address_prefix_monitor" {
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

#Container Apps & Environment
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
variable "traffic_weight" {
  type = number
}
#CountySuite API
variable "db_name" {
  type = string
}
variable "db_user" {
  type = string
}
variable "db_password" {
  type = string
}
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

#Monitoring
variable "retention" {
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
#SQL Server
variable "azurerm_mssql_server_id" {
  type = string
}
variable "azurerm_container_app_id" {
  type = string
}
