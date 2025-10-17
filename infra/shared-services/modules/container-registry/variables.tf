variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}