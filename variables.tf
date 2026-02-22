###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

###common vars
variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

variable "single_ip" {
  type        = string
  description = "ip-адрес"
  default     = "192.168.0.1"

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.single_ip)) && alltrue([for octet in split(".", var.single_ip) : tonumber(octet) >=0 && tonumber(octet) <= 255])
    error_message = "Значение переменной single_ip должно быть корректным IPv4 адресом"
  }
}

variable "ip_list" {
  type        = list(string)
  description = "список ip-адресов"
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]

  validation {
    condition = alltrue([
      for ip in var.ip_list : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", ip)) && alltrue([for octet in split(".", ip) : tonumber(octet) >=0 && tonumber(octet) <= 255])
    ])
    error_message = "Все элементы списка ip_list должны быть корректными IPv4 адресами"
  }
}

variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    condition     = (var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor)
    error_message = "There can be only one MacLeod"
  }
}

variable "access_key" {
  description = "Access Key ID для сервисного аккаунта"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Secret Key для сервисного аккаунта"
  type        = string
  sensitive   = true
}
