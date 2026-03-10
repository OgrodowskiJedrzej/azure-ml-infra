output "endpoints_subnet_id" {
  value = azurerm_subnet.subnet_endpoints.id
}

output "compute_subnet_id" {
  value = azurerm_subnet.subnet_compute.id
}

output "dns_zones" {
  value = azurerm_private_dns_zone.dns_zones
}