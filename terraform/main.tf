provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-aks"
  resource_group_name = "rg-demo"
  location            = "canadacentral"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = "rg-demo"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = "rg-demo"
  location            = "canadacentral"
  cluster_name        = "aks-demo"
  subnet_id           = azurerm_subnet.aks.id
}

module "agw" {
  source              = "./modules/appgw"
  resource_group_name = "rg-demo"
  location            = "canadacentral"
  appgw_name          = "agw-demo"
  vnet_name           = azurerm_virtual_network.vnet.name
  subnet_name         = "snet-appgw"
  subnet_id           = azurerm_subnet.appgw.id
  backend_pool        = "backend-pool"
  backend_http_settings = {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }
  frontend_ip_config = {
    name       = "frontend-ip"
    public_ip  = true
  }
}

module "cosmos" {
  source              = "./modules/cosmosdb"
  resource_group_name = "rg-demo"
  location            = "canadacentral"
  account_name        = "cosmos-demo"
}

output "aks_id" {
  value = module.aks.aks_id
}

output "gateway_ip" {
  value = module.agw.gateway_ip
}

output "cosmos_endpoint" {
  value = module.cosmos.cosmos_endpoint
}
