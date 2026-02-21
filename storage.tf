# # Создаем сервисный аккаунт для работы с S3
# resource "yandex_iam_service_account" "s3_sa" {
#   name        = "s3-terraform-sa"
#   description = "Service account for Terraform state"
# }

# # Назначаем права на чтение/запись в Object Storage
# resource "yandex_resourcemanager_folder_iam_member" "s3_sa_editor" {
#   folder_id = var.folder_id
#   role      = "storage.editor"
#   member    = "serviceAccount:${yandex_iam_service_account.s3_sa.id}"
# }

# # Создаем статический ключ доступа для S3
# resource "yandex_iam_service_account_static_access_key" "s3_sa_key" {
#   service_account_id = yandex_iam_service_account.s3_sa.id
#   description        = "Static access key for S3"
# }

# Создаем S3 bucket для хранения state
# resource "yandex_storage_bucket" "tfstate" {
#   bucket     = "tfstate-${var.folder_id}"
#   access_key = yandex_iam_service_account_static_access_key.s3_sa_key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.s3_sa_key.secret_key

#   # # Включаем версионирование для backup
#   # versioning {
#   #   enabled = true
#   # }

#   # Блокировка публичного доступа
#   anonymous_access_flags {
#     read = false
#     list = false
#   }
# }
