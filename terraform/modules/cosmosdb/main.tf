variable "resource_group_name" {}
variable "location" {}
variable "account_name" {}

resource "azurerm_cosmosdb_account" "db" {
  name                = var.account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

output "cosmos_endpoint" {
  value = azurerm_cosmosdb_account.db.endpoint
}
