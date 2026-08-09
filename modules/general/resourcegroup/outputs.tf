output "resource_group_names" {
  value = {
    for key, rg in azurerm_resource_group.resource_groups :
    key => rg.name
  }
}

output "resource_group_locations" {
  value = {
    for key, rg in azurerm_resource_group.resource_groups :
    key => rg.location
  }
}


