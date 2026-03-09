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

module "network" {
  source                 = "./modules/network"
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.locaction
  vnet_name              = "vnet-mlops"
  address_space          = "10.0.0.0/16"
  endpoints_subnet_prefix = "10.0.1.0/24"
  compute_subnet_prefix   = "10.0.2.0/24"
}

module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name        = "sa${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location                    = module.resource_group.location
  account_replication_type    = "LRS"
  access_tier                 = "Hot"
  subnet_id                   = module.network.endpoints_subnet_id
  private_dns_zone_id         = TODO
}

module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name              = "kv${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location                    = module.resource_group.location
}

module "application_insights" {
  source = "./modules/application_insights"

  application_insights_name   = "ai${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location                    = module.resource_group.location
}

module "container_registry" {
  source = "./modules/container_registry"

  container_registry_name     = "cr${var.resource_group_name}${random_string.suffix.result}"
  azurerm_resource_group_name = module.resource_group.rg_name
  location                    = module.resource_group.location
}

module "azureml_workspace" {
  source = "./modules/azureml_workspace"

  azureml-workspace-name  = var.workspace_name
  resource_group_name     = module.resource_group.rg_name
  location                = module.resource_group.location
  container_registry_id   = module.container_registry.id
  application_insights_id = module.application_insights.id
  key_vault_id            = module.key_vault.id
  storage_account_id      = module.storage_account.storage_account_id
}

module "compute_cluster" {
  source = "./modules/compute_cluster"

  cluster_name = var.cluster_name
  location     = module.resource_group.location
  workspace_id = module.azureml_workspace.id
  vm_size      = var.cluster_instance_type
}