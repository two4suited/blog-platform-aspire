data "terraform_remote_state" "shared" {
  backend = "remote"
  
  config = {
    organization = "BS_INC"
    workspaces = {
      name = "shared-services"
    }
  }
}

# Resource Group for environment infrastructure
resource "azurerm_resource_group" "environment" {
  name     = "rg-${var.environment}"
  location = var.location
  tags     = merge(var.tags, { Environment = var.environment })
}

# App Service Plan - shared compute for all apps in this environment
module "app_service_plan" {
  source = "./modules/app-service-plan"
  
  resource_group_name = azurerm_resource_group.environment.name
  environment         = var.environment
  location            = azurerm_resource_group.environment.location
  tags                = merge(var.tags, { Environment = var.environment })
}