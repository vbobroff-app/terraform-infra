# yandex/provider.tf
provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.catalog_id
  service_account_key_file = "../sa-key.json"
}