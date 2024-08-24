output "front_door_endpoint" {
  value = "https://${azurerm_frontdoor.fd-cdn.frontend_endpoint[0].host_name}"
}
