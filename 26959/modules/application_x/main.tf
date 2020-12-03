resource "azurerm_function_app" "main" {
  name                       = "${var.prefix}-function"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = var.service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_primary_access_key
}
