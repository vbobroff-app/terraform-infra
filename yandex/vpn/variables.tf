# core/vpn/variables.tf

variable "network_id" {
  type        = string
  description = "ID of the VPC network for VPN Gateway"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block of the subnet for security rules"
}

variable "vpn_gateway_name" {
  type        = string
  default     = "contabo-vpn-gateway"
  description = "Name of the VPN Gateway"
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone for external IP address"
}