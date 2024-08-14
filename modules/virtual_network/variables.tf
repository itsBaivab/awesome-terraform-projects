variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network in which the subnet will be created."
}
variable "location" {
  type        = string
  description = "The location/region where the virtual machine will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the virtual machine will be created."
}

