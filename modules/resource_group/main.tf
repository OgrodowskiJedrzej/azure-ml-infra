variable "resource_group_name" {
    type = string
    description = "Name for resource group."
}
variable "location" {
    type = string
    description = "Default location of Azure resource."
}

resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}