module "storage_account" {
  source = "./modules/storage_account"
  storage_account_name = "sa-${var.resource_group_name}"
  azurerm_resource_group_name = var.resource_group_name
  location = var.location
  account_replication_type = "LRS"
  access_tier = "Hot"
}

module "key_vault" {
  source = "./modules/key_vault"
  key_vault_name = "kv-${var.resource_group_name}"
  location = var.location
  azurerm_resource_group_name = var.resource_group_name
}