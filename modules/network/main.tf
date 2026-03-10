resource "azurerm_virtual_network" "vnet" {
    name = var.vnet_name
    location = var.location
    address_space = [ var.address_space ]
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet_endpoints" {
  name                 = "subnet-endpoints"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [ var.endpoints_subnet_prefix ]
  
  private_endpoint_network_policies = "Enabled"
}

resource "azurerm_subnet" "subnet_compute" {
  name                 = "subnet-compute"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [ var.compute_subnet_prefix ]
}