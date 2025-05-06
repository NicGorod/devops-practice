

locals {
  resource_group_name = split("/", var.resource_group_id)[4]

  # Calculate VNet address space from subnet prefixes
  all_subnet_prefixes = flatten([
    for subnet in values(var.subnets) : subnet.address_prefixes
  ])
  
  # Get the smallest network that contains all subnets
  vnet_cidr = [cidrhost(
    format("%s/%s",
      cidrhost(local.all_subnet_prefixes[0], 0),
      tonumber(split("/", local.all_subnet_prefixes[0])[1]) - 1
    ),
    0
  )]
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = local.resource_group_name
  address_space       = local.vnet_cidr
  tags                = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                                           = each.key
  resource_group_name                            = local.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = each.value.address_prefixes
  service_endpoints                              = each.value.service_endpoints
  private_endpoint_network_policies_enabled      = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled  = each.value.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = each.value.delegate
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service
        actions = delegation.value.actions
      }
    }
  }
}

