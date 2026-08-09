data "azurerm_policy_definition" "allowed_resource_types" {
  display_name = "Allowed resource types"
}

data "azurerm_resource_group" "target" {
  for_each = var.policies

  name = each.value.resource_group_name
}

resource "azurerm_resource_group_policy_assignment" "allowed_resource_types" {
  for_each = var.policies

  name                 = each.key
  resource_group_id    = data.azurerm_resource_group.target[each.key].id
  policy_definition_id = data.azurerm_policy_definition.allowed_resource_types.id
  display_name         = "Allowed resource types - ${each.value.resource_group_name}"
  description          = "Restricts resources deployed in this resource group."

  parameters = jsonencode({
    listOfResourceTypesAllowed = {
      value = each.value.allowed_resource_types
    }
  })
}