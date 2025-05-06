variable "vnet_name" {
  description = "The name of VNet"
  type        = string
}

variable "resource_group_id" {
  description = "The ID of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Virtual Network should be created"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the Virtual Network"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    address_prefixes                               = list(string)
    service_endpoints                              = optional(list(string), [])
    private_endpoint_network_policies_enabled      = optional(bool, true)
    private_link_service_network_policies_enabled  = optional(bool, true)
    delegate = optional(list(object({
      name    = string
      service = string
      actions = list(string)
    })), [])
  }))
}

