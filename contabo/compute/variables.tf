# contabo/compute/variables.tf

variable "image_id" {
  type        = string
  description = "OS image ID for the VPS"
  default     = null  # Делаем optional

  validation {
    condition     = can(regex("^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$", var.image_id))
    error_message = "Image ID must be a valid UUID format."
  }
}

variable "product_id" {
  type        = string
  description = "VPS product type"
  default     = "V92"
}

variable "region" {
  type        = string
  description = "Region for the VPS"
  default     = "EU"
  
  validation {
    condition     = contains(["EU", "US", "SG"], var.region)
    error_message = "Region must be one of: EU, US, SG."
  }
}

variable "display_name" {
  type        = string
  description = "Display name for the VPS"
  default     = "vpn-wireguard-server"
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

variable "add_ons" {
  description = "Additional services and licenses for the VPS"
  type        = map(any)
  default     = {}
  
  validation {
    condition = alltrue([
      for k, v in var.add_ons : contains([
        "additional-ipv4", "additional-ipv6", "backup", "monitoring",
        "cpanel-license", "plesk-license", "windows-license", "additional-disk"
      ], k)
    ])
    error_message = "Add-on key must be one of: additional-ipv4, additional-ipv6, backup, monitoring, cpanel-license, plesk-license, windows-license, additional-disk."
  }
}

variable "cancel_date" {
  description = "The date on which the instance will be automatically cancelled (YYYY-MM-DD). Use with caution!"
  type        = string
  default     = null
  
  validation {
    condition     = var.cancel_date == null || can(regex("^\\d{4}-\\d{2}-\\d{2}$", var.cancel_date))
    error_message = "Cancel date must be in YYYY-MM-DD format or null."
  }
}

variable "default_user" {
  description = "Default user name created for login during installation. For Linux: 'admin' (sudo privileges) or 'root' (direct root access). For Windows: 'admin' or 'administrator'"
  type        = string
  default     = "admin"
  
  validation {
    condition     = contains(["admin", "root", "administrator"], var.default_user)
    error_message = "Default user must be one of: admin, root, administrator."
  }
}

variable "user_data" {
  description = "Cloud-Init script for automatic server configuration"
  type        = string
  default     = null
  validation {
    condition     = var.user_data == null || length(var.user_data) <= 16384
    error_message = "User data must be less than 16384 characters."
  }
}

variable "license" {
  description = "Additional license (e.g., for software on your product)"
  type        = string
  default     = null
}


variable "ssh_keys" {
  description = "Array of secretIds of public SSH keys"
  type        = list(number)
  default     = []
  validation {
    condition     = length(var.ssh_keys) <= 10
    error_message = "Maximum 10 SSH keys allowed."
  }
}