resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}
data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "keyvaults" {
    for_each = var.keyvaults
  name = lower(
    replace(
      "${each.key}${random_integer.suffix.result}",
      "-",
      ""
    )
  )
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
 
 
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  
  }
