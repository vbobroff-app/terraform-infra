#Yandex vars
variable "cloud_name" {
  type        = string
  sensitive   = true
  description = "Cloud name Organization"
}

variable "cloud_id" {
  type    = string
  sensitive   = true
  description = "Cloud infra-cloud ID"
}

variable "catalog_name" {
  type        = string
  sensitive   = true
  description = "Catalog name in infra-cloud"
}

variable "catalog_id" {
  type        = string
  sensitive   = true
  description = "Catalog ID in infra-cloud"
}

variable "terraform_sa_name" {
  type        = string
  description = "Terraform Service Account name"
}

variable "terraform_sa_id" {
  type        = string
  sensitive   = true
  description = "Terraform Service Account ID"
}

variable "zone_1_a" {
  type        = string
  description = "Default zone"
}
