resource "azurerm_storage_account" "docs" {
  name                     = "st${var.project_name}"
  resource_group_name      = azurerm_resource_group.docs.name
  location                 = azurerm_resource_group.docs.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = local.common_tags
}

resource "azurerm_storage_account_static_website" "docs" {
  storage_account_id = azurerm_storage_account.docs.id
  index_document     = "index.html"
  error_404_document = "404.html"
}

# Output the primary endpoint
output "static_website_url" {
  value       = azurerm_storage_account.docs.primary_web_endpoint
  description = "The URL of the static website"
}

output "storage_account_name" {
  value       = azurerm_storage_account.docs.name
  description = "The name of the storage account"
}