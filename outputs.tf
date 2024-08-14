output "resource_group_name" {
  value = module.resource_group.resource_group_name
}
output "virtual_network_name" {
  value = module.virtual_network.virtual_network_name
}
output "subnet_name" {
  value = module.subnet.subnet_prefix
}

output "vitual_machine_name" {
  value = module.linux_virtual_machine.vitual_machine_name
}

output "network_interface_id" {
  value = module.network_interface_card.network_interface_id
}


