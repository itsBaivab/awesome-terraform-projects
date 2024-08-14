variable "resource_group_name"{
    type = string
    description = "The name of the resource group in which the resources will be created."
}
variable "location"{
    type = string
    description = "The location/region where the resources will be created."
}
variable "nic_prefix"{
    type = string
    description = "The nic prefix."
}
variable "subnet_id" {
    type = string
    description = "The subnet ID."
}