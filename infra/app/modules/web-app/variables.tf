variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "service_plan_id" {
  description = "App Service Plan ID"
  type        = string
}

variable "acr_login_server" {
  description = "Container Registry login server"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}