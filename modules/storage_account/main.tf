resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.azurerm_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier
  public_network_access_enabled = false
}

resource "azurerm_private_endpoint" "pe" {
  name                = "pe-${azurerm_storage_account.sa.name}"
  location            = var.location
  resource_group_name = var.azurerm_resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-storage"
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = [ "blob" ]
  }

  private_dns_zone_group {
    name                 = "dns-group"
    private_dns_zone_ids = [ var.private_dns_zone_id ]
  }
}