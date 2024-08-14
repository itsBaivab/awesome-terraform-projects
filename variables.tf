variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resources will be created."
}

variable "location" {
  type        = string
  description = "The location/region where the resources will be created."
}

variable "subnet_prefix" {
  type        = string
  description = "The subnet prefix."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network in which the subnet will be created."
}

variable "nic_prefix" {
  type        = string
  description = "The nic prefix."
}

variable "vm_prefix" {
  type        = string
  description = "The vm prefix."
}
variable "network_interface_id" {
  type        = list(string)
  description = "The ID of the network interface to attach to the virtual machine."
}