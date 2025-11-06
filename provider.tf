terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.85.0"
    }
  }
}

provider "yandex" {
  cloud_id  = "infra-cloud"
  folder_id = "b1gj58ckj9gn47utncss"
  service_account_key_file = "sa-key.json"
}