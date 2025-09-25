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

variable "keyvault" {
  type = string
}

variable "keyvault_sku_name" {
  type = string
}

variable "storage_account_type" {
  description = "Storage account SKU to be lowest tier"
  type        = string
}

variable "vm_size" {
  description = "Virtual Machine size"
  type = string
}

variable "eviction_policy" {
  description = "The action performed if the spot price exceeds the maximum bid price"
  type = string
}

variable "max_bid_price" {
  description = "The maximum price you're willing to pay (in USD) for the VM's hourly rate"
  type = number
}

variable "vnet_name" {
  type = string
}