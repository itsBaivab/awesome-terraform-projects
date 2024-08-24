resource "azurerm_frontdoor" "fd-cdn" {
  name                = var.front_door_name
  resource_group_name = var.resource_group_name

  backend_pool {
    name = "backendPool1"
    backend {
      host_header = var.static_website_host_endpoint
      address     = var.static_website_host_endpoint
      http_port   = 80
      https_port  = 443
      priority    = 1
      weight      = 50
    }

    load_balancing_name = "loadBalancingSettings"
    health_probe_name   = "healthProbeSettings"
  }

  frontend_endpoint {
    name      = "frontendEndpoint1"
    host_name = "${var.front_door_name}.azurefd.net"
  }

  routing_rule {
    name               = "routingrule1"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontendEndpoint1"]
    forwarding_configuration {
      forwarding_protocol = "HttpsOnly"
      backend_pool_name   = "backendPool1"
    }
  }

  backend_pool_load_balancing {
    name                           = "loadBalancingSettings"
    sample_size                    = 4
    successful_samples_required    = 2
    additional_latency_milliseconds = 0
  }

  backend_pool_health_probe {
    name                = "healthProbeSettings"
    protocol            = "Https"
    path                = "/"
    interval_in_seconds = 120
  }
}
