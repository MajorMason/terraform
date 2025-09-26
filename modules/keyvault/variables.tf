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

#KeyVault
variable "keyvault_name" {
  type = string
}

variable "keyvault_sku_name" {
  type = string
}
