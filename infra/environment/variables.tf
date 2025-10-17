variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default = "test"
  validation {
    condition     = contains(["dev", "staging", "prod","test"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westus2"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "Platform"
  }
}