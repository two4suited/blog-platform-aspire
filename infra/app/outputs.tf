output "web_app_name" {
  description = "Web App name"
  value       = module.web_app.name
}

output "web_app_url" {
  description = "Web App URL"
  value       = module.web_app.url
}

output "web_app_default_hostname" {
  description = "Web App default hostname"
  value       = module.web_app.default_hostname
}