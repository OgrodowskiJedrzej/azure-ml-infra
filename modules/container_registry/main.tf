resource "azurerm_container_registry" "cr" {
    name                = var.container_registry_name
    resource_group_name = var.azurerm_resource_group_name
    location            = var.location
    sku                 = "Basic"
    admin_enabled       = true
    public_network_access_enabled = false
}

resource "azurerm_private_endpoint" "cr_pe" {
  name = "pe-${azurerm_container_registry.cr.name}"
  location = var.location
  resource_group_name = var.azurerm_resource_group_name
  subnet_id = var.subnet_id

  private_service_connection {
    name = "psc-cr"
    private_connection_resource_id = azurerm_container_registry.cr.id
    is_manual_connection = false
    subresource_names = [ "registry" ]
  }

  private_dns_zone_group {
    name = "dns-group-cr"
    private_dns_zone_ids = [ var.private_dns_zone_id ]
  }
}