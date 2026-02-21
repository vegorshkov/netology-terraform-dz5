locals {
  network_name = var.env_name != null && var.env_name != "" ? "${var.env_name}-network" : (var.name != null ? var.name : "default-network")
}
