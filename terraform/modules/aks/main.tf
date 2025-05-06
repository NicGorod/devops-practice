

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix         = "${var.cluster_name}-dns"
  kubernetes_version = "1.27.7"

  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size            = var.node_vm_size
    vnet_subnet_id     = var.subnet_id
    min_count          = 1
    max_count          = 3
    os_disk_size_gb    = 50
    
    tags = var.tags
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.tags, {
    Environment = "Production"
    Managed_By  = "Terraform"
  })
}


