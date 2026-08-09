module "resource_groups" {
  source          = "./modules/general/resourcegroup"
  resource_groups = var.resource_groups
}
module "vnet" {
  source              = "./modules/networking/vnet"
  location            = module.resource_groups.resource_group_locations["network-group"]
  resource_group_name = module.resource_groups.resource_group_names["network-group"]
  vnets               = var.vnets
  security_rules      = var.security_rules
}

module "logging" {
  source = "./modules/monitoring/logging"

  log_analytics_workspace = var.log_analytics_workspace

  depends_on = [module.resource_groups]
}

module "azure-storage" {
  source           = "./modules/storage/azurestorage"
  storage_accounts = var.storage_accounts
  depends_on       = [module.resource_groups]

}

module "databases" {
  source             = "./modules/storage/sqldatabases"
  sql_admin_password = var.sql_admin_password
  dbapp_environment  = var.dbapp_environment
  depends_on         = [module.resource_groups]
}

module "security" {
  source    = "./modules/security"
  keyvaults = var.keyvaults


}

module "policy" {
  source     = "./modules/governance/policy"
  policies   = var.policies
  depends_on = [module.resource_groups]
}