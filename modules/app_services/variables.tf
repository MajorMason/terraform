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

#Service Plan & App Services
variable "serviceplan_sku" {
    type = string
}

variable "os_type" {
  type = string
}

variable "always_on" {
  type = bool
}

variable "always_on_api" {
  type = bool
}

variable "load_balancing" {
  type = string
}

variable "bit_worker" {
  type = string
}

variable "current_stack" {
  type = string
}

variable "dotnet_version" {
  type = string
}

variable "connection_string_name" {
  type = string
}

variable "connection_string_type" {
  type = string
}

variable "connection_string_value" {
  type = string
}
