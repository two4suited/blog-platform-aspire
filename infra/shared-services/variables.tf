variable "location" {
  description = "Azure region for shared resources"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "Platform"
    Layer     = "Shared-Services"
  }
}