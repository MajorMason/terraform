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

variable "private_address_prefix" {
  type = list(string)
}

#Output Variables
#SQL Server
variable "azurerm_mssql_server_id" {
  type = string
}
variable "azurerm_container_app_id" {
  type = string
}
