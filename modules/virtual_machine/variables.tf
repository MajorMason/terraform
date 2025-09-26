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

#Virtual Machine
variable "vm_name" {
  type = string
}

variable "vm_size" {
  description = "Virtual Machine size"
  type = string
}

variable "admin_username" {
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

variable "storage_account_type" {
  description = "Storage account SKU to be lowest tier"
  type        = string
}

variable "custom_data" {
  type = string
}

variable "network_interface_ids" {
  type = string
}

variable "nic_ids" {
  type = map(string)
  default = {
    dev     = "nic-dev"
    prod    = "nic-prod"
  }
}
