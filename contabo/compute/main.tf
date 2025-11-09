# contabo/compute/main.tf

resource "contabo_instance" "vps" {
  # Обязательные поля
  image_id     = var.image_id
  product_id   = var.product_id
  region       = var.region
  display_name = var.display_name
  period       = var.period

  # Опциональные поля
  default_user = var.default_user
  ssh_keys     = length(var.ssh_keys) > 0 ? var.ssh_keys : null
  user_data    = var.user_data
  license      = var.license

  # Add-ons (дополнительные услуги)
  dynamic "add_ons" {
    for_each = var.add_ons
    content {
      id       = add_ons.key
      quantity = try(add_ons.value.quantity, 1)
    }
  }

  lifecycle {
    ignore_changes = [
      user_data,
      ssh_keys,
    ]
    prevent_destroy = false
  }
}