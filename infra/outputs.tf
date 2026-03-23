output "external_ip" {
  value = yandex_vpc_address.kittygram.external_ipv4_address[0].address
}

output "gateway_url" {
  value = "http://${yandex_vpc_address.kittygram.external_ipv4_address[0].address}:${var.gateway_port}"
}

output "ssh_user" {
  value = var.vm_user
}