terraform {
  backend "s3" {
    bucket = "tfstate-b1g883r36u9293g7u1gc"
    key    = "terraform.tfstate"
    region = "ru-central1"
    access_key = var.access_key
    secret_key = var.secret_key
    versioning = true
  }
}
