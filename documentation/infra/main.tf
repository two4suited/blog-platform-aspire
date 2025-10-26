locals {
  common_tags = {
    purpose    = "platform-documentation"
    managed_by = "terraform"
    project    = var.project_name
  }
}

resource "azurerm_resource_group" "docs" {
  name     = "rg-${var.project_name}"
  location = var.location

  tags = local.common_tags
}