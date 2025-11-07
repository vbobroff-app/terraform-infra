terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
  
    contabo = {
      source = "contabo/contabo"
      version = ">= 0.1.32"
    }
  }

  # Бэкенд раскомментируем позже
}