resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.environment}-${var.app_name}-${random_string.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  
  site_config {
    always_on = var.environment == "prod" ? true : false
    
    application_stack {
      docker_image_name   = "${var.acr_login_server}/${var.app_name}:latest"
      docker_registry_url = "https://${var.acr_login_server}"
    }
  }

  identity {
    type = "SystemAssigned"
  }
  
  tags = var.tags
}

# Get ACR ID for role assignment
data "azurerm_container_registry" "acr" {
  name                = split(".", var.acr_login_server)[0]
  resource_group_name = "rg-shared-services"
}

# Grant Web App access to pull images from ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_linux_web_app.main.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}