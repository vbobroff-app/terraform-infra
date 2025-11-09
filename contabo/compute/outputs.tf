# ./contabo/compute/outputs.tf

output "instance_info" {
  description = "Complete information about the created VPS instance"
  value = {
    id           = contabo_instance.vps.id
    name         = contabo_instance.vps.display_name
    image_id     = contabo_instance.vps.image_id
    region       = contabo_instance.vps.region
    status       = contabo_instance.vps.status
    public_ip    = try(contabo_instance.vps.ip_config[0].v4[0].ip, "Pending")
    private_ip   = try(contabo_instance.vps.ip_config[0].v4[0].gateway, "Pending")
    created_date = contabo_instance.vps.created_date
    cpu_cores    = contabo_instance.vps.cpu_cores
    ram_mb       = contabo_instance.vps.ram_mb
    disk_mb      = contabo_instance.vps.disk_mb
    os_type      = contabo_instance.vps.os_type
  }
}

output "connection_info" {
  description = "Information for connecting to the VPS"
  value = {
    public_ip    = try(contabo_instance.vps.ip_config[0].v4[0].ip, "Pending assignment")
    default_user = contabo_instance.vps.default_user
    ssh_command  = "ssh ${contabo_instance.vps.default_user}@${try(contabo_instance.vps.ip_config[0].v4[0].ip, "IP_PENDING")}"
  }
  sensitive = false
}