locals {
  common_tags = {
    environment = var.environment
    purpose     = "platform-documentation"
    managed_by  = "terraform"
    project     = var.project_name
  }
}

resource "azurerm_resource_group" "docs" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = local.common_tags
}