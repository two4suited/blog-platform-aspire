output "id" {
  description = "Web App ID"
  value       = azurerm_linux_web_app.main.id
}

output "name" {
  description = "Web App name"
  value       = azurerm_linux_web_app.main.name
}

output "default_hostname" {
  description = "Web App default hostname"
  value       = azurerm_linux_web_app.main.default_hostname
}

output "url" {
  description = "Web App URL"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}