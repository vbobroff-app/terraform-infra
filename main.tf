# root/main.tf

module "network" {
  source = "./yandex/network"
}

module "vpn" {
  source = "./yandex/vpn"

  network_id   = module.network.vpc_network_id
  subnet_cidr  = module.network.subnet_cidr
  vpn_gateway_name = "contabo-vpn-gateway"
  zone         = "ru-central1-a"
}


# Contabo

# Data source для получения информации об образе ДО создания инстанса
# data "contabo_image" "selected" {
#   id = var.image_id
#   description = "Information about the selected OS image"
# }

# module "vps_contabo_simple" {
#   source = "./contabo/compute"
  
#   image_id     = var.image_id # data.contabo_image.selected.id  #  afecbb85-e2fc-46f0-9684-b46b1faf00bb Ubuntu 22.00 LTS
#   product_id   = var.product_id # "V92" Самый дешевый VPS
#   region       = var.region # "EU" Европейский трафик
#   display_name =  "vps-wireguard"
#   period       = var.period # 1  Месячный контракт
# }
