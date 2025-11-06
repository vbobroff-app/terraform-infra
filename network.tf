# Создание облачной сети
resource "yandex_vpc_network" "vpn_network" {
  name        = "vpn-network"
  description = "Network for VPN Gateway to Contabo"
}

# Создание подсети 192.168.10.0/24
resource "yandex_vpc_subnet" "vpn_subnet" {
  name           = "vpn-subnet"
  description    = "Subnet for VPN clients"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpn_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  
  dhcp_options {
    domain_name_servers = ["8.8.8.8", "1.1.1.1"]
  }
}