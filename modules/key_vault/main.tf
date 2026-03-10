data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
    name                        = var.key_vault_name
    location                    = var.location
    enabled_for_disk_encryption = true
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days  = 7
    sku_name                    = "standard"
    purge_protection_enabled    = false
    resource_group_name         = var.azurerm_resource_group_name
}

resource "azurerm_private_endpoint" "kv_pe" {
  name = "pe-${azurerm_key_vault.kv.name}"
  resource_group_name = var.azurerm_resource_group_name
  location = var.location
  subnet_id = var.subnet_id

  private_service_connection {
    name = "psc-kv"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection = false
    subresource_names = [ "vault" ]
  }

  private_dns_zone_group {
    name = "dns-group-kv"
    private_dns_zone_ids = [ var.private_dns_zone_id ]
  }
}