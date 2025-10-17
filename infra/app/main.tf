data "terraform_remote_state" "shared" {
  backend = "remote"
  
  config = {
    organization = "BS_INC"
    workspaces = {
      name = "shared-services"
    }
  }
}

data "terraform_remote_state" "environment" {
  backend = "remote"
  
  config = {
    organization = "BS_INC"
    workspaces = {
      name = "env-${var.environment}"
    }
  }
}

# Resource Group for application
resource "azurerm_resource_group" "app" {
  name     = "rg-${var.environment}-${var.app_name}"
  location = var.location
  tags = merge(var.tags, { 
    Environment = var.environment
    Application = var.app_name
  })
}

# Web App
module "web_app" {
  source = "./modules/web-app"
  
  resource_group_name = azurerm_resource_group.app.name
  app_name            = var.app_name
  environment         = var.environment
  location            = azurerm_resource_group.app.location
  service_plan_id     = data.terraform_remote_state.environment.outputs.app_service_plan_id
  acr_login_server    = data.terraform_remote_state.shared.outputs.acr_login_server
  tags                = merge(var.tags, { 
    Environment = var.environment
    Application = var.app_name
  })
}