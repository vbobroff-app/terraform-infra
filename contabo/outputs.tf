# Contabo output

output "image_info" {
  description = "Information about the selected OS image"
  value = data.contabo_image.selected
}

output "contabo_vps_ip" {
  description = "Public IP of Contabo VPS"
  value       = module.vps_contabo_simple.connection_info.public_ip
}

output "contabo_vps_id" {
  description = "ID of Contabo VPS"
  value       = module.vps_contabo_simple.instance_info.id
}

output "contabo_vps_status" {
  description = "Status of the VPS"
  value       = module.vps_contabo_simple.instance_info.status
}

output "contabo_ssh_command" {
  description = "SSH command to connect to VPS"
  value       = module.vps_contabo_simple.connection_info.ssh_command
}

output "contabo_vps_specs" {
  description = "VPS specifications"
  value = {
    cpu_cores = module.vps_contabo_simple.instance_info.cpu_cores
    ram_mb    = module.vps_contabo_simple.instance_info.ram_mb
    disk_mb   = module.vps_contabo_simple.instance_info.disk_mb
    os_type   = module.vps_contabo_simple.instance_info.os_type
  }
}
