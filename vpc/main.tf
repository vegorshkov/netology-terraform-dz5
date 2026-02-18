terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  alias     = "secondtask"
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "secondtask" {
  provider = yandex.secondtask
  name     = var.name
}

resource "yandex_vpc_subnet" "secondtask" {
  provider       = yandex.secondtask
  name           = "${var.name}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.secondtask.id
  v4_cidr_blocks = [var.cidr]
}
