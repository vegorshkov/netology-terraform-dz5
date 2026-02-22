variable "name" {
  type        = string
  description = "Name of the VPC network (for backward compatibility)"
  default     = null
}

variable "zone" {
  type        = string
  description = "Zone for the subnet (for backward compatibility)"
  default     = null
}

variable "cidr" {
  type        = string
  description = "CIDR block for the subnet (for backward compatibility)"
  default     = null
}

variable "token" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "env_name" {
  type        = string
  description = "Environment name (e.g., production, develop)"
  default     = null
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "List of subnets with zones and CIDR blocks"
  default     = []
}

variable "single_ip" {
  type        = string
  description = "IP-адрес"

  default     = "192.168.0.1"  # можно менять на некорректный для теста

  validation {
    condition     = can(cidrhost("${var.single_ip}/32", 0))
    error_message = "Значение должно быть корректным IP-адресом"
  }
}

variable "ip_list" {
  type        = list(string)
  description = "Список IP-адресов"

  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"] # тест корректных

  validation {
    condition     = alltrue([for ip in var.ip_list : can(cidrhost("${ip}/32", 0))])
    error_message = "Все элементы списка должны быть корректными IP-адресами"
  }
}

