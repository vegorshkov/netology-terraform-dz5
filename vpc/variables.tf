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
