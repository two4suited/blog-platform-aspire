output "id" {
  description = "App Service Plan ID"
  value       = azurerm_service_plan.main.id
}

output "name" {
  description = "App Service Plan name"
  value       = azurerm_service_plan.main.name
}