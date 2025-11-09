#Yandex vars

variable "cloud_name" {
  type        = string
  sensitive   = true
  description = "Cloud name Organization"
}

variable "cloud_id" {
  type    = string
  sensitive   = true
  description = "Cloud infra-cloud ID"
}

variable "catalog_name" {
  type        = string
  sensitive   = true
  description = "Catalog name in infra-cloud"
}

variable "catalog_id" {
  type        = string
  sensitive   = true
  description = "Catalog ID in infra-cloud"
}

variable "terraform_sa_name" {
  type        = string
  description = "Terraform Service Account name"
}

variable "terraform_sa_id" {
  type        = string
  sensitive   = true
  description = "Terraform Service Account ID"
}

variable "zone_1_a" {
  type        = string
  description = "Default zone"
}

#Contabo vars

variable "contabo_client_id" {
  type        = string
  description = "Contabo API Client ID"
  sensitive   = true
}

variable "contabo_client_secret" {
  type        = string
  description = "Contabo API Client Secret"
  sensitive   = true
}


variable "contabo_user" {
  type        = string
  description = "Contabo account email"
  sensitive   = true
}

variable "contabo_password" {
  type        = string
  description = "Contabo account password"
  sensitive   = true
}


#Contabo VPS vars

variable "image_id" {
  description = "ID of the OS image for the VPS. Default is Ubuntu 22.04 with cPanel"
  type        = string
  #default     = "afecbb85-e2fc-46f0-9684-b46b1faf00bb"
  
  validation {
    condition     = can(regex("^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$", var.image_id))
    error_message = "Image ID must be a valid UUID format."
  }
}

variable "product_id" {
  description = "Product ID for the VPS instance. Default is VPS 10 SSD (V92) - €3.60/month"
  type        = string
  default     = "V92"
  
  validation {
    condition     = can(regex("^(V9[1-9]|V10[0-7]|V[8-9]|V1[0-6])$", var.product_id))
    error_message = "Product ID must be a valid Contabo VPS/VDS product ID (V91-V107, V8-V16)."
  }
}

variable "region" {
  description = "Region where to deploy the VPS. Default is EU"
  type        = string
  default     = "EU"
  
  validation {
    condition     = contains(["EU", "US-west", "US-east", "Singapore"], var.region)
    error_message = "Region must be one of: EU, US-west, US-east, Singapore."
  }
}

variable "display_name" {
  description = "Display name for the VPS instance"
  type        = string
  default     = "terraform-contabo-vps"
  
  validation {
    condition     = length(var.display_name) >= 3 && length(var.display_name) <= 64
    error_message = "Display name must be between 3 and 64 characters long."
  }
}

variable "period" {
  description = "Initial contract period in months. Default is 1 month"
  type        = number
  default     = 1
  
  validation {
    condition     = contains([1, 3, 6, 12], var.period)
    error_message = "Period must be one of: 1, 3, 6, 12 months."
  }
}