# Azure Container Registry - shared across all environments
resource "azurerm_resource_group" "shared" {
  name     = "rg-shared-services"
  location = var.location
  tags     = var.tags
}

module "container_registry" {
  source = "./modules/container-registry"
  resource_group_name = azurerm_resource_group.shared.name
  location            = var.location
  tags                = var.tags
}
