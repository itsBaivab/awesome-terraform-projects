resource "azurerm_virtual_network" "vnet-demo" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       =  ["10.0.0.0/16"]
  tags = {
    environment = "dev"
  }
}