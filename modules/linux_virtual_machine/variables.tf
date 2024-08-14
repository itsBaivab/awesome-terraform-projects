variable "vm_prefix" {
  type        = string
  description = "The prefix for the virtual machine."
}
variable "location" {
  type        = string
  description = "The location/region where the virtual machine will be created."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the virtual machine will be created."
}
variable "network_interface_id" {
  type        = list(string)
  description = "The ID of the network interface to attach to the virtual machine."
}
