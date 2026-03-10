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

    public_network_access_enabled = false
}

resource "azurerm_private_endpoint" "aml_pe" {
  name = "pe-${azurerm_machine_learning_workspace.aml.name}"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = var.subnet_id

  private_service_connection {
      name = "psc-aml"
      private_connection_resource_id = azurerm_machine_learning_workspace.aml.id
      is_manual_connection = false
      subresource_names = [ "amlworkspace" ]
    }

  private_dns_zone_group {
    name = "dns-group-aml"
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}