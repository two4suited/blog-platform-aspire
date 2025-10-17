output "id" {
  description = "Container Registry ID"
  value       = azurerm_container_registry.main.id
}

output "login_server" {
  description = "Container Registry login server"
  value       = azurerm_container_registry.main.login_server
}

output "name" {
  description = "Container Registry name"
  value       = azurerm_container_registry.main.name
}