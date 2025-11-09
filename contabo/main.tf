# Data source для получения информации об образе ДО создания инстанса
data "contabo_image" "selected" {
  id = var.image_id
  description = "Information about the selected OS image"
}

module "vps_contabo_simple" {
  source = "./compute"
  
  image_id     = data.contabo_image.selected.id  #  afecbb85-e2fc-46f0-9684-b46b1faf00bb Ubuntu 22.00 LTS
  product_id   = var.product_id # "V92" Самый дешевый VPS
  region       = var.region # "EU" Европейский трафик
  display_name =  "vps-contabo"
  period       = var.period # 1  Месячный контракт

  depends_on = [data.contabo_image.selected]
}