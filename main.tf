# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }

# resource "yandex_vpc_subnet" "develop" {
#   name           = "${var.vpc_name}-subnet"
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    ssh_public_key = var.vms_ssh_root_key
  }
}

module "vpc_dev" {
  source = "./vpc"
  name   = "develop"
  zone   = var.default_zone
  cidr   = "10.0.1.0/24"
  token    = var.token       # добавил по заданию 2 чтобы взять значения переменных из root модуля
  cloud_id = var.cloud_id
  folder_id = var.folder_id
}

module "marketing_vm" {
  source         = "git::https://github.com/vegorshkov/yandex_compute_instance.git?ref=stable/2026-02-18" #добавлен тег версии
  instance_name  = "${var.vm_web_name}-marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  # network_id     = yandex_vpc_network.develop.id      # закоментировано по заданию 2
  network_id     = module.vpc_dev.subnet_info.network_id
  # subnet_ids     = [yandex_vpc_subnet.develop.id]     # закоментировано по заданию 2
  subnet_ids     = [module.vpc_dev.subnet_id]
  subnet_zones   = [var.default_zone]
  labels         = local.projects.marketing.labels
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

module "analytics_vm" {
  source         = "git::https://github.com/vegorshkov/yandex_compute_instance.git?ref=stable/2026-02-18" # добавлен тег версии
  instance_name  = "${var.vm_web_name}-analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  # network_id     = yandex_vpc_network.develop.id   # закоментировано по заданию 2
  network_id     = module.vpc_dev.subnet_info.network_id
  # subnet_ids     = [yandex_vpc_subnet.develop.id]   # закоментировано по заданию 2
  subnet_ids     = [module.vpc_dev.subnet_id]
  subnet_zones   = [var.default_zone]
  labels         = local.projects.analytics.labels
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

