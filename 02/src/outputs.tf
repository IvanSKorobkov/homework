output "external_ip_db" {
  value = yandex_compute_instance.platform_db.network_interface.0.nat_ip_address
}

output "external_ip" {
  value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
}

