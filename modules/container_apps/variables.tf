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

variable "revision_mode" {
  type = string
}

variable "container_name_fe" {
  type = string
}

variable "container_name_be" {
  type = string
}

variable "container_image_url" {
  type = string
}

variable "container_cpu" {
  type = number
}

variable "container_memory" {
  type = string
}
