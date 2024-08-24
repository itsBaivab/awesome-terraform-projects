variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resources will be created."
}

variable "location" {
  type        = string
  description = "The location/region where the resources will be created."
}

# variable "storage_account_name" {
#   type        = string
#   description = "The name of the storage account"
# }

variable "front_door_name" {
  type        = string
  description = "The name of the Front Door"
}