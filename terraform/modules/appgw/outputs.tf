# Outputs
output "application_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.agw.id
}

output "application_gateway_name" {
  description = "The name of the Application Gateway"
  value       = azurerm_application_gateway.agw.name
}

output "public_ip_address" {
  description = "The public IP address of the Application Gateway"
  value       = azurerm_public_ip.pip.ip_address
}

output "backend_pool_id" {
  description = "The ID of the backend address pool"
  value       = one(azurerm_application_gateway.agw.backend_address_pool).id
}
