terraform {
  required_version = "~>1.12.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.183.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }

  # Добавляем пустой для "terraform init -migrate-state -backend-config=backend.hcl"
  backend "s3" {}

  # временно комментирую от сюда и...
  # backend "s3" {
  #   bucket  = "tfstate-b1g883r36u9293g7u1gc"
  #   key     = "terraform.tfstate"
  #   region  = "ru-central1"

  #   use_lockfile = true

  #   endpoints = {
  #     s3 = "https://storage.yandexcloud.net"
  #   }

  #   skip_region_validation      = true
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true
  #   skip_s3_checksum            = true
  # }
  # временно комментирую до сюда...
  # https://azbyka.ru/otechnik/Spravochniki/tolkovyj-slovar-zhivogo-velikorusskogo-jazyka-v-i-dalja-bukva-s/2856
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
