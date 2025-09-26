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

variable "nic_ids" {
  type = map(string)
  default = {
    dev  = "nic-dev"
    prod = "nic-prod"
  }
}
