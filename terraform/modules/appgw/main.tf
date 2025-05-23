resource "azurerm_public_ip" "pip" {
  name                = "${var.appgw_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_application_gateway" "agw" {
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  sku {
    name     = var.sku
    tier     = var.tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontend-port"
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_config.name
    public_ip_address_id = var.frontend_ip_config.public_ip ? azurerm_public_ip.pip.id : null
  }

  backend_address_pool {
    name = var.backend_pool
  }

  backend_http_settings {
    name                  = var.backend_http_settings.name
    cookie_based_affinity = var.backend_http_settings.cookie_based_affinity
    path                  = "/"
    port                  = var.backend_http_settings.port
    protocol              = var.backend_http_settings.protocol
    request_timeout       = var.backend_http_settings.request_timeout
  }

  http_listener {
    name                           = "basic-http-listener"
    frontend_ip_configuration_name = var.frontend_ip_config.name
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "basic-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "basic-http-listener"
    backend_address_pool_name  = var.backend_pool
    backend_http_settings_name = var.backend_http_settings.name
    priority                   = 100
  }

  lifecycle {
    create_before_destroy = true
  }
}
