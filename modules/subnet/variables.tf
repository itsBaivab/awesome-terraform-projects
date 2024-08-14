variable "subnet_prefix" {
  type        = string
  description = "The subnet prefix."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resources will be created."
}
variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network in which the subnet will be created."
}