provider "azurerm" {
  features {}
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = "rg-demo"
  location            = "canadacentral"
  cluster_name        = "aks-demo"
}

module "agw" {
  source              = "./modules/appgw"
  resource_group_name = "rg-demo"
  location            = "canadacentral"
  gateway_name        = "agw-demo"
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
