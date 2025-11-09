# 03_provider_contabo.tf

provider "contabo" {
  oauth2_client_id     = var.contabo_client_id
  oauth2_client_secret = var.contabo_client_secret
  oauth2_user          = var.contabo_user
  oauth2_pass          = var.contabo_password
}

# Data source для получения информации об образе ДО создания инстанса
data "contabo_image" "selected" {
  id = var.image_id
  description = "Information about the selected OS image"
}