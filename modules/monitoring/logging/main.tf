resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}




resource "azurerm_log_analytics_workspace" "log_workspaces" {
    for_each = var.log_analytics_workspace
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

