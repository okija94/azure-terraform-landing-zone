variable "resource_groups" {
  type = map(object({
    location = string
    tags     = map(string)
  }))
}

variable "vnets" {
  type = map(object({
    vnet_name     = string
    address_space = list(string)

    subnets = map(object({
      address_prefixes = list(string)
      associate_nsg    = optional(bool, true)
    }))
  }))
}

variable "security_rules" {
  type = map(object({
    priority               = number
    destination_port_range = string
    source_address_prefix  = string
  }))
}

variable "log_analytics_workspace" {
  type = map(object({
    location            = string
    resource_group_name = string
  }))

}

variable "storage_accounts" {
  type = map(object({
    location                 = string
    resource_group_name      = string
    account_tier             = string
    account_replication_type = string
    account_kind             = string
    is_hns_enabled           = bool
  }))

}

variable "dbapp_environment" {
  type = map(object({
    resource_group_name = string
    location            = string
    sku                 = string
  }))
}
variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "keyvaults" {
  type = map(object({
    location            = string
    resource_group_name = string
  }))

}

variable "policies" {
  type = map(object({
    resource_group_name    = string
    allowed_resource_types = list(string)
  }))
}