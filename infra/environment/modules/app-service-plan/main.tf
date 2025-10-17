resource "azurerm_service_plan" "main" {
  name                = "asp-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.environment == "prod" ? "P1v3" : "P0v3"
  
  tags = var.tags
}