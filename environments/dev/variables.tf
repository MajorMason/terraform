#This is where we define input variables for the entire project
#While the "type" line isn't required, its recommended to have so that others know what type
#of string the variable is
variable "location" {
  type        = string
  description = "The Azure region to deploy to"
}

variable "environment" {
  type = string
}

variable "keyvault_sku_name" {
  type = string
}

variable "storage_account_type" {
  type        = string
  description = "Storage account SKU to be lowest tier"
}
