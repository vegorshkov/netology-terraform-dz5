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

# Создаем сеть
resource "yandex_vpc_network" "secondtask" {
  provider = yandex.secondtask
  name     = local.network_name
}

# Создаем подсети динамически (для задания 4* ДЗ№4)
resource "yandex_vpc_subnet" "this_dynamic" {
  count = length(var.subnets)
  
  provider = yandex.secondtask
  name     = "${var.env_name}-subnet-${count.index + 1}"
  zone     = var.subnets[count.index].zone
  network_id = yandex_vpc_network.secondtask.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
}

# Для обратной совместимости (старый способ с одной подсетью)
resource "yandex_vpc_subnet" "secondtask" {
  count = length(var.subnets) == 0 ? 1 : 0
  
  provider = yandex.secondtask
  name     = var.name != "" ? "${var.name}-subnet" : "default-subnet"
  zone     = var.zone != "" ? var.zone : "ru-central1-a"
  network_id = yandex_vpc_network.secondtask.id
  v4_cidr_blocks = [var.cidr != "" ? var.cidr : "10.0.1.0/24"]
}
