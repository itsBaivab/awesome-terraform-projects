output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "storage_account_name" {
    value = module.storage_account.storage_account_name
}

output "static_website_host_endpoint" {
  value = module.storage_account.storage_account_primary_web_host
}

output "front_door_endpoint" {
  value = module.front_door.front_door_endpoint
}