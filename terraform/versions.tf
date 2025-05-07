terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "azurerm" {
  features {}
  # subscription_id = "your-subscription-id"
  # tenant_id       = "your-tenant-id"
}
