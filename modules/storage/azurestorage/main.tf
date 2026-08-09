resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}





resource "azurerm_storage_account" "storage_account" {
  for_each = var.storage_accounts

  name = lower(
    replace(
      "${each.key}${random_integer.suffix.result}",
      "-",
      ""
    )
  )

  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  is_hns_enabled           = each.value.is_hns_enabled


}

