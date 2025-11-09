output "vpc_network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.vpn_network.id
}

output "subnet_id" {
  description = "ID of the created subnet" 
  value       = yandex_vpc_subnet.vpn_subnet.id
}

output "subnet_cidr" {
  description = "CIDR block of the subnet"
  value       = yandex_vpc_subnet.vpn_subnet.v4_cidr_blocks[0]
}