variable "name" {
  type        = string
  description = "Name of the VPC network"
}

variable "zone" {
  type        = string
  description = "Zone for the subnet"
}

variable "cidr" {
  type        = string
  description = "CIDR block for the subnet"
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

