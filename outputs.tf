# outputs.tf (в корне проекта)

# Outputs из модуля network
output "vpc_network_id" {
  description = "ID of the VPC network"
  value       = module.network.vpc_network_id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.network.subnet_id
}

output "subnet_cidr" {
  description = "CIDR block of the subnet"
  value       = module.network.subnet_cidr
}

# Outputs из модуля vpn
output "vpn_gateway_id" {
  description = "ID of the VPN Gateway"
  value       = module.vpn.vpn_gateway_id
}

output "vpn_gateway_ip" {
  description = "External IP address for VPN connection"
  value       = module.vpn.vpn_gateway_ip
  sensitive   = false
}

output "security_group_id" {
  description = "ID of the VPN security group"
  value       = module.vpn.security_group_id
}

# Автоматически создается в Yandex Cloud - смотреть в консоле, не управляется terraform
# default_security_group_id = (known after apply)