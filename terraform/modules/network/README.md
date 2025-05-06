# VNet module

This module creates a VNet and subnets in Azure.
It also creates a network security group and associates it with the subnets.

## Module usage

Note: keep in mind this module calculates VNet address space based on the subnets provided.


```hcl
module "vnet" {
  source            = "./modules/network"
  name              = "my-vnet"
  resource_group_id = azurerm_resource_group.example.id
  location          = "canadaeast"
  subnets = {
    "subnet1" = {
      address_prefixes = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
    }
    "subnet2" = {
      address_prefixes = ["10.0.2.0/24"]
      delegate = [
        {
          name    = "delegation"
          service = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      ]
    }
    "subnet3" = {
      address_prefixes = ["10.0.3.0/24"]
      private_endpoint_network_policies_enabled = false
    }
  }
  tags = {
    Environment = "Production"
    Project     = "MyProject"
  }
}
```

