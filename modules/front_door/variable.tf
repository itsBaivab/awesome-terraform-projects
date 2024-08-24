variable "front_door_name" {
  type        = string
  description = "The name of the Front Door"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location where the resources will be created"
}

variable "static_website_host_endpoint" {
  type        = string
  description = "The endpoint of the static website hosted on Azure Storage"
}
