variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "platformdocs"
  
  validation {
    condition     = length(var.project_name) <= 15 && can(regex("^[a-z0-9]+$", var.project_name))
    error_message = "Project name must be 15 characters or less and contain only lowercase letters and numbers."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westus2"
}

variable "custom_domain" {
  description = "Custom domain for documentation site (optional)"
  type        = string
  default     = "docs.brianpsheridan.com"
}