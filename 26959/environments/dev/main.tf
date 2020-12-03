provider "azurerm" {
  features {}
}

module "base" {
  source   = "../../modules/base"
  location = var.location
  prefix   = var.prefix
}

module "application_x" {
  source                     = "../../modules/application_x"
  location                   = var.location
  prefix                     = var.prefix
  resource_group_name        = module.base.resource_group_name
  service_plan_id            = module.base.service_plan_id
  storage_account_name       = module.base.storage_account_name
  storage_primary_access_key = module.base.storage_primary_access_key
}
