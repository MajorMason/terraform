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
