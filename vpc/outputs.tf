output "subnet_id" {
  value = length(yandex_vpc_subnet.secondtask) > 0 ? yandex_vpc_subnet.secondtask[0].id : null
}

output "subnet_info" {
  value = length(yandex_vpc_subnet.secondtask) > 0 ? yandex_vpc_subnet.secondtask[0] : null
}

output "dynamic_subnet_ids" {
  description = "Map of zone to subnet ID for dynamic subnets"
  value = length(var.subnets) > 0 ? {
    for idx, subnet in yandex_vpc_subnet.this_dynamic :
    var.subnets[idx].zone => subnet.id
  } : {}
}

output "dynamic_subnet_info" {
  description = "List of dynamic subnets with zone, cidr, and id"
  value = length(var.subnets) > 0 ? [
    for idx, subnet in yandex_vpc_subnet.this_dynamic : {
      zone = var.subnets[idx].zone
      cidr = var.subnets[idx].cidr
      id   = subnet.id
    }
  ] : []
}

output "network_id" {
  value = yandex_vpc_network.secondtask.id
}

output "network_name" {
  value = yandex_vpc_network.secondtask.name
}
