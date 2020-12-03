output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "service_plan_id" {
  value = azurerm_app_service_plan.main.id
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "storage_primary_access_key" {
  value     = azurerm_storage_account.main.primary_access_key
  sensitive = true
}

