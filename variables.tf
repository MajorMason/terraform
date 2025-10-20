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

#Virtual Machine
variable "vm_size" {
  description = "Virtual Machine size"
  type        = string
}

variable "eviction_policy" {
  description = "The action performed if the spot price exceeds the maximum bid price"
  type        = string
}

variable "max_bid_price" {
  description = "The maximum price you're willing to pay (in USD) for the VM's hourly rate"
  type        = number
}

variable "storage_account_type" {
  description = "Storage account SKU to be lowest tier"
  type        = string
}

variable "nic_ids" {
  type = map(string)
  default = {
    dev  = "nic-dev"
    prod = "nic-prod"
  }
}

variable "admin_username" {
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

variable "sku_name" {
  type = string
}

variable "zone_redundant" {
  type = bool
}
