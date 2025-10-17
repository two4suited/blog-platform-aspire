output "acr_id" {
  description = "Container Registry ID"
  value       = module.container_registry.id
}

output "acr_login_server" {
  description = "Container Registry login server"
  value       = module.container_registry.login_server
}

output "acr_name" {
  description = "Container Registry name"
  value       = module.container_registry.name
}
output "resource_group_name" {
  description = "Shared services resource group name"
  value       = azurerm_resource_group.shared.name
}
