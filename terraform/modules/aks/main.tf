variable "resource_group_name" {}
variable "location" {}
variable "cluster_name" {}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    env = "demo"
  }
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
