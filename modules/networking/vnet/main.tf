resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets

  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
locals {
  subnets = merge([
    for vnet_key, vnet in var.vnets : {
      for subnet_key, subnet in vnet.subnets :
      "${vnet_key}-${subnet_key}" => {
        vnet_key         = vnet_key
        subnet_name      = subnet_key
        address_prefixes = subnet.address_prefixes
        associate_nsg    = subnet.associate_nsg
      }
    }
  ]...)
}
resource "azurerm_subnet" "subnet" {
  for_each = local.subnets

  name                 = each.value.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
}
resource "azurerm_network_security_group" "workload_nsg" {
  name                = "workload-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = "*"
    }
  }
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each = {
    for key, subnet in local.subnets :
    key => subnet
    if subnet.associate_nsg
  }

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.workload_nsg.id
}