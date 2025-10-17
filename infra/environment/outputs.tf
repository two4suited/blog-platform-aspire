output "app_service_plan_id" {
  description = "App Service Plan ID"
  value       = module.app_service_plan.id
}

output "app_service_plan_name" {
  description = "App Service Plan name"
  value       = module.app_service_plan.name
}

# Pass through shared services outputs for convenience
output "acr_login_server" {
  description = "Container Registry login server from shared services"
  value       = data.terraform_remote_state.shared.outputs.acr_login_server
}