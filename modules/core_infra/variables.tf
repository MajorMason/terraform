#While the "type" line isn't required, its recommended to have so that others know what type
#of string the variable is
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
  default = null
}

variable "address_prefix" {
  type = list(string)
}

#KeyVault
variable "keyvault" {
  type = string
  default = null
}

variable "keyvault_sku_name" {
  type = string
}

variable "storage_account_type" {
  description = "Storage account SKU to be lowest tier"
  type        = string
  default = null
}

#Virtual Machine
variable "vm_size" {
  description = "Virtual Machine size"
  type = string
  default = null
}

variable "eviction_policy" {
  description = "The action performed if the spot price exceeds the maximum bid price"
  type = string
  default = null
}

variable "max_bid_price" {
  description = "The maximum price you're willing to pay (in USD) for the VM's hourly rate"
  type = number
  default = null
}

variable "nic_ids" {
  type = map(string)
  default = {
    dev     = "nic-dev"
    prod    = "nic-prod"
  }
}
