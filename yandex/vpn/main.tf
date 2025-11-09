# core/vpn/main.tf

# Выделение внешнего IP для VPN Gateway
resource "yandex_vpc_address" "vpn_gateway_ip" {
  name = "vpn-gateway-ip"
  
  external_ipv4_address {
    zone_id = var.zone
  }

  # Явно указываем, что это статический IP
  lifecycle {
    prevent_destroy = false # Разрешить удаление при destroy
  }
}

# Создание VPN Gateway (пробуем VPC Gateway)
resource "yandex_vpc_gateway" "contabo_gateway" {  # ← vpc_gateway
  name = var.vpn_gateway_name
  shared_egress_gateway {}
}

# Security Group для VPN
resource "yandex_vpc_security_group" "vpn_security" {
  name        = "vpn-security-group"
  network_id  = var.network_id

  # Разрешаем IKE (UDP 500)
  ingress {
    protocol       = "UDP"
    description    = "Allow IKE traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 500
  }

  # Разрешаем IPSec NAT-T (UDP 4500)
  ingress {
    protocol       = "UDP"
    description    = "Allow IPSec NAT-T traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 4500
  }

  # Разрешаем весь исходящий трафик
  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем внутренний трафик в подсети
  ingress {
    protocol       = "ANY"
    description    = "Allow traffic from VPN subnet"
    v4_cidr_blocks = [var.subnet_cidr]
  }
}