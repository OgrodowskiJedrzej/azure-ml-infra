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