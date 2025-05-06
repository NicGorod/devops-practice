variable "resource_group_name" {}
variable "location" {}
variable "gateway_name" {}

resource "azurerm_public_ip" "pip" {
  name                = "${var.gateway_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "agw" {
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gateway-ip"
    subnet_id = "fake-subnet-id" # Use a dummy string for now
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = "mock-backend-pool"
    ip_addresses = "10.0.1.5"  # dummy IP

  }

  backend_http_settings {
    name                  = "mock-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "frontend"
    frontend_port_name             = "http"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "mock-backend-pool"
    backend_http_settings_name = "mock-http-settings"
  }
}

output "gateway_ip" {
  value = azurerm_public_ip.pip.ip_address
}
