resource "azurerm_machine_learning_compute_cluster" "cc-gpu" {
    name                          = var.cluster_name
    location                      = var.location
    machine_learning_workspace_id = var.workspace_id
    vm_size                       = var.vm_size
    vm_priority                   = "LowPriority"

    scale_settings {
      min_node_count = 0
      max_node_count = 1
      scale_down_nodes_after_idle_duration = 30
    }

    identity {
      type = "SystemAssigned"
    }
}