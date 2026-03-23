resource "yandex_vpc_network" "kittygram" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "kittygram" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.kittygram.id
  v4_cidr_blocks = [var.subnet_cidr]
}

resource "yandex_vpc_security_group" "kittygram" {
  name       = var.security_group_name
  network_id = yandex_vpc_network.kittygram.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "Gateway HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = var.gateway_port
  }

  egress {
    protocol       = "ANY"
    description    = "All outgoing traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

resource "yandex_vpc_address" "kittygram" {
  name = "kittygram-public-ip"

  external_ipv4_address {
    zone_id = var.zone
  }
}

resource "yandex_compute_instance" "kittygram" {
  name        = var.vm_name
  zone        = var.zone
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 4
  }



  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram.id
    nat                = true
    nat_ip_address     = yandex_vpc_address.kittygram.external_ipv4_address[0].address
    security_group_ids = [yandex_vpc_security_group.kittygram.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yaml", {
      vm_user        = var.vm_user
      ssh_public_key = var.ssh_public_key
    })
  }
}