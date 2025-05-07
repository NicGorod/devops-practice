# Application Gateway Module

This module creates an Azure Application Gateway with a WAF policy and a backend pool.

## Example usage
```hcl

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "canadacentral"
  tags    = {
    Environment = "Production"
    Managed_By  = "Terraform"
  }
}

# First create the networking
module "network" {
  source            = "./modules/network"
  resource_group_id = azurerm_resource_group.rg.id
  location          = "canadacentral"
  vnet_name         = "vnet-agw-prod"
  
  subnets = {
    "subnet" = {
      address_prefixes = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.ContainerRegistry"]
      # Enable required features for AKS
      private_endpoint_network_policies_enabled = true
      private_link_service_network_policies_enabled = true
    }
  }

  tags = {
    Environment = "Production"
    Managed_By  = "Terraform"
  }
}

# Create the Application Gateway

module "appgw" {
  source              = "./modules/appgw"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = module.network.vnet_name
  subnet_name         = module.network.subnet_name
  subnet_id           = module.network.subnet_id

  appgw_name          = "appgw-prod"
  sku                 = "Standard_v2"
  capacity            = 2
  tier                = "Standard_v2"
  frontend_ip_config = {
    name      = "frontend-ip"
    public_ip = true
  }
  frontend_port       = "80"
  backend_pool        = "backend-pool"
  backend_http_settings = {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  tags = {
    Environment = "Production"
    Managed_By  = "Terraform"
  }
}
```

