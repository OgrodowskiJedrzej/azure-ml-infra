provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.azurerm_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier
}

resource "azurerm_key_vault" "kv" {
    name                        = var.key_vault_name
    location                    = var.location
    enabled_for_disk_encryption = true
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days  = 7
    sku_name                    = "Standard"
    purge_protection_enabled    = false
    resource_group_name         = var.azurerm_resource_group_name
}

resource "azurerm_application_insights" "ai" {
    name                = var.application_insights_name
    location            = var.location
    resource_group_name = var.azurerm_resource_group_name
    application_type    = "web"
}

resource "azurerm_container_registry" "cr" {
    name                = var.container_registry_name
    resource_group_name = var.azurerm_resource_group_name
    location            = var.location
    sku                 = "Basic"
    admin_enabled       = true
}