# core/vpn/outputs.tf
output "vpn_gateway_id" {
  description = "ID of the created VPN Gateway"
  value       = yandex_vpc_gateway.contabo_gateway.id 
}

output "vpn_gateway_ip" {
  description = "External IP address of VPN Gateway"
  value       = yandex_vpc_address.vpn_gateway_ip.external_ipv4_address[0].address
}

output "security_group_id" {
  description = "ID of the VPN security group"
  value       = yandex_vpc_security_group.vpn_security.id
}