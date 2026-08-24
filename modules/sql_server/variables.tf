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

variable "sql_lock" {
  type = string
}

#SQL Server & DBs
#SQL Server
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
#Database Common
variable "license_type" {
  type = string
}
variable "max_size_gb" {
  type = number
}
variable "sql_sku_name" {
  type = string
}
variable "zone_redundant" {
  type = bool
}
variable "retention_days" {
  type = number
}
variable "weekly_retention" {
  type = string
}
variable "monthly_retention" {
  type = string
}
variable "week_of_year" {
  type = number
}
#Primary Database
variable "primary_backup_interval" {
  type = number
}
variable "primary_yearly_retention" {
  type = string
}
#Repository Database
variable "repo_backup_interval" {
  type = number
}
variable "repo_yearly_retention" {
  type = string
}
