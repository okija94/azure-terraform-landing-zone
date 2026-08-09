resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_mssql_server" "sqlserver" {
  for_each = var.dbapp_environment

  name = lower(
    replace(
      "${each.key}${random_integer.suffix.result}",
      "-",
      ""
    )
  )

  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "databases" {
  for_each = var.dbapp_environment

  name = lower(
    replace(
      "${each.key}db${random_integer.suffix.result}",
      "-",
      ""
    )
  )

  server_id    = azurerm_mssql_server.sqlserver[each.key].id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = each.value.sku
}