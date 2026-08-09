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

