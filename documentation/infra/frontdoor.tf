
resource "azurerm_cdn_frontdoor_profile" "docs" {
  name                = "fd-${var.project_name}"
  resource_group_name = azurerm_resource_group.docs.name
  sku_name            = "Standard_AzureFrontDoor"

  tags = local.common_tags
}

resource "azurerm_cdn_frontdoor_endpoint" "docs" {
  name                     = "ep-${var.project_name}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.docs.id
  
  tags = local.common_tags
}

resource "azurerm_cdn_frontdoor_origin_group" "docs" {
  name                     = "og-${var.project_name}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.docs.id

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    path                = "/"
    request_type        = "HEAD"
    protocol            = "Https"
    interval_in_seconds = 100
  }
}

resource "azurerm_cdn_frontdoor_origin" "docs" {
  name                          = "origin-${var.project_name}"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.docs.id

  enabled                        = true
  host_name                      = replace(replace(azurerm_storage_account.docs.primary_web_endpoint, "https://", ""), "/", "")
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = replace(replace(azurerm_storage_account.docs.primary_web_endpoint, "https://", ""), "/", "")
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_route" "docs" {
  name                          = "route-${var.project_name}"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.docs.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.docs.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.docs.id]
  cdn_frontdoor_custom_domain_ids = var.custom_domain != "" ? [azurerm_cdn_frontdoor_custom_domain.docs[0].id] : []

  supported_protocols    = ["Http", "Https"]
  patterns_to_match      = ["/*"]
  forwarding_protocol    = "HttpsOnly"
  link_to_default_domain = true
  https_redirect_enabled = true

  depends_on = [
    azurerm_cdn_frontdoor_origin.docs,
    azurerm_cdn_frontdoor_custom_domain.docs
  ]
}

output "frontdoor_endpoint" {
  value       = azurerm_cdn_frontdoor_endpoint.docs.host_name
  description = "The Front Door endpoint hostname"
}

resource "azurerm_cdn_frontdoor_custom_domain" "docs" {
  count = var.custom_domain != "" ? 1 : 0

  name                     = "custom-domain-${var.project_name}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.docs.id
  host_name                = var.custom_domain

  tls {
    certificate_type    = "ManagedCertificate"   
  }
}
