variable "service_account_key_file" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "vm_name" {
  type    = string
  default = "kittygram-vm"
}

variable "network_name" {
  type    = string
  default = "kittygram-network"
}

variable "subnet_name" {
  type    = string
  default = "kittygram-subnet"
}

variable "security_group_name" {
  type    = string
  default = "kittygram-sg"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "vm_user" {
  type    = string
  default = "deployer"
}

variable "ssh_public_key" {
  type = string
}

variable "gateway_port" {
  type    = number
  default = 80
}