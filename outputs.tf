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


# Contabo

# output "image_info" {
#   description = "Information about the selected OS image"
#   value = {
#     id            = data.contabo_image.selected.id
#     description = data.contabo_image.selected.description
#     name          = data.contabo_image.selected.name
#     version       = data.contabo_image.selected.version
#     os_type       = data.contabo_image.selected.os_type
#     format        = data.contabo_image.selected.format
#     status        = data.contabo_image.selected.status
#     standard_image = data.contabo_image.selected.standard_image
#     creation_date = data.contabo_image.selected.creation_date
#     last_updated = data.contabo_image.selected.last_updated
#     uploaded_size_mb = data.contabo_image.selected.uploaded_size_mb
#   }
# }

# output "contabo_vps_ip" {
#   description = "Public IP of Contabo VPS"
#   value       = module.vps_contabo_simple.connection_info.public_ip
# }

# output "contabo_vps_id" {
#   description = "ID of Contabo VPS"
#   value       = module.vps_contabo_simple.instance_info.id
# }

# output "contabo_vps_status" {
#   description = "Status of the VPS"
#   value       = module.vps_contabo_simple.instance_info.status
# }

# output "contabo_ssh_command" {
#   description = "SSH command to connect to VPS"
#   value       = module.vps_contabo_simple.connection_info.ssh_command
# }

# output "contabo_vps_specs" {
#   description = "VPS specifications"
#   value = {
#     cpu_cores = module.vps_contabo_simple.instance_info.cpu_cores
#     ram_mb    = module.vps_contabo_simple.instance_info.ram_mb
#     disk_mb   = module.vps_contabo_simple.instance_info.disk_mb
#     os_type   = module.vps_contabo_simple.instance_info.os_type
#   }
# }
