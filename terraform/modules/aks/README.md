# Moduel to provision AKS cluster



# Example usage
```hcl
# First create the networking
module "network" {
  source            = "./modules/network"
  resource_group_id = azurerm_resource_group.example.id
  location          = "canadacentral"
  vnet_name         = "vnet-aks-prod"
  
  subnets = {
    "aks-subnet" = {
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

# Then deploy AKS using the subnet from the network module
module "aks" {
  source              = "./modules/aks"
  cluster_name        = "aks-prod"
  resource_group_name = azurerm_resource_group.example.name
  location            = "canadacentral"
  subnet_id           = module.network.subnet_ids["aks-subnet"]
  
  node_count   = 2
  node_vm_size = "Standard_D2s_v3"
  
  tags = {
    Environment = "Production"
    Managed_By  = "Terraform"
  }

  depends_on = [module.network]
}
```

