resource "azurerm_application_insights" "ai" {
    name                = var.application_insights_name
    location            = var.location
    resource_group_name = var.azurerm_resource_group_name
    application_type    = "web"
}