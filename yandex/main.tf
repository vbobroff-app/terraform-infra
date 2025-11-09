# ./yandex/main.tf

module "network" {
  source = "./network"
}

module "vpn" {
  source = "./vpn"

  network_id   = module.network.vpc_network_id
  subnet_cidr  = module.network.subnet_cidr
  vpn_gateway_name = "contabo-vpn-gateway"
  zone         = "ru-central1-a"
}
