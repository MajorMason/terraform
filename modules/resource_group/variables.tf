#While the "type" line isn't required, its recommended to have so that others know what type
#of string the variable is
variable "name" {
  description = "The name of the resource group, required in our root main.tf file"
  type = string
}

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
