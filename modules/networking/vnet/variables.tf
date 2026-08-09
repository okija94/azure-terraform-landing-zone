variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
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
    priority                 = number
    destination_port_range  = string
    source_address_prefix    = string
  }))
}