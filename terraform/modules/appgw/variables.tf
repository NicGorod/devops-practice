# Variables
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the Application Gateway should be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet for Application Gateway"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for Application Gateway"
  type        = string
}

variable "appgw_name" {
  description = "Name of the Application Gateway"
  type        = string
}

variable "sku" {
  description = "SKU of the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "tier" {
  description = "Tier of the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "capacity" {
  description = "Capacity units of the Application Gateway"
  type        = number
  default     = 2
}

variable "frontend_ip_config" {
  description = "Frontend IP configuration for the Application Gateway"
  type = object({
    name      = string
    public_ip = bool
  })
  default = {
    name      = "frontend-ip-config"
    public_ip = true
  }
}

variable "frontend_port" {
  description = "Frontend port number"
  type        = string
  default     = "80"
}

variable "backend_pool" {
  description = "Name of the backend pool"
  type        = string
}

variable "backend_http_settings" {
  description = "Configuration for backend HTTP settings"
  type = object({
    name                  = string
    cookie_based_affinity = string
    port                  = number
    protocol              = string
    request_timeout       = number
  })
  default = {
    name                  = "default-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
