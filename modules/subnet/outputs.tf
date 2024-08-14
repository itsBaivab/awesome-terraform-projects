output "subnet_prefix" {
  value = azurerm_subnet.internal-subnet.name
}
output "subnet_id" {
    value = azurerm_subnet.internal-subnet.id
}