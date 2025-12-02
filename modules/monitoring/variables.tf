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

variable "retention" {
    description = "Amount of days log analytics data is to be retained"
    type = string
}
