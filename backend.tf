terraform {
  backend "s3" {
    bucket = "tfstate-b1g883r36u9293g7u1gc"
    key    = "terraform.tfstate"
    region = "ru-central1-a"  # попробуйте с зоной
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}
