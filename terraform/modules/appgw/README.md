# Application Gateway Module

# This module creates an Azure Application Gateway with a WAF policy and a backend pool.

### Example usage
```hcl
module "appgw" {
  source              = "./modules/appgw"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  vnet_name           = module.network.vnet_name
  subnet_name         = module.network.subnet_name
  subnet_id           = module.network.subnet_id

  appgw_name          = "appgw-prod"
  sku                 = "Standard_v2"
  capacity            = 2
  tier                = "Standard_v2"
  frontend_ip_config  = "frontend-ip-config"
  frontend_port       = "80"
  backend_pool        = "backend-pool"
  backend_http_settings= "backend-http-settings"

  tags = {
    Environment = "Production"
    Managed_By  = "Terraform"
  }
}
```

