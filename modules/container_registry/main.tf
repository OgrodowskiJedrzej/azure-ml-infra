resource "azurerm_container_registry" "cr" {
    name                = var.container_registry_name
    resource_group_name = var.azurerm_resource_group_name
    location            = var.location
    sku                 = "Basic"
    admin_enabled       = true
}