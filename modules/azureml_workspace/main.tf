resource "azurerm_machine_learning_workspace" "aml" {
    name                          = var.azureml-workspace-name
    location                      = var.location
    resource_group_name           = var.resource_group_name
    storage_account_id            = var.storage_account_id
    key_vault_id                  = var.key_vault_id
    application_insights_id       = var.application_insights_id
    container_registry_id         = var.container_registry_id

    identity {
        type = "SystemAssigned"
    }
}