module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name = "sa${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location = module.resource_group.location
  account_replication_type = "LRS"
  access_tier = "Hot"
}

module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name = "kv${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location = module.resource_group.location
}

module "application_insights" {
  source = "./modules/application_insights"

  application_insights_name = "ai${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location = module.resource_group.location
}

module "container_registry" {
  source = "./modules/container_registry"

  container_registry_name = "cr${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location = module.resource_group.location
}

module "azureml_workspace" {
  source = "./modules/azureml_workspace"

  azureml-workspace-name = var.workspace_name
  resource_group_name = module.resource_group.rg_name
  location = module.resource_group.location
  container_registry_id = module.container_registry.id
  application_insights_id = module.application_insights.id
  key_vault_id = module.key_vault.id
  storage_account_id = module.storage_account.storage_account_id
}

module "compute_cluster" {
  source = "./modules/compute_cluster"

  cluster_name = var.cluster_name
  location = module.resource_group.location
  workspace_id = module.azureml_workspace.id
  vm_size = "Standard_DS2_v2"
}