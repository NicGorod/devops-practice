output "aks_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  description = "Kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "cluster_identity" {
  description = "System assigned identity of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

