data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    ssh_public_key = var.vms_ssh_root_key
  }
}

module "vpc_main" {
  source    = "./vpc"
  env_name  = "main"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

module "marketing_vm" {
  source         = "git::https://github.com/vegorshkov/yandex_compute_instance.git?ref=v1.0.0"

  instance_name  = "${var.vm_web_name}-marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  network_id     = module.vpc_main.network_id
  subnet_ids     = [module.vpc_main.dynamic_subnet_ids["ru-central1-a"]]
  subnet_zones   = ["ru-central1-a"]

  labels         = local.projects.marketing.labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

module "analytics_vm" {
  source         = "git::https://github.com/vegorshkov/yandex_compute_instance.git?ref=v1.0.0"

  instance_name  = "${var.vm_web_name}-analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  network_id     = module.vpc_main.network_id
  subnet_ids     = [module.vpc_main.dynamic_subnet_ids["ru-central1-a"]]
  subnet_zones   = ["ru-central1-a"]

  labels         = local.projects.analytics.labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}
