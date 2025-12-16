output "rg_name" {
  value = var.resource_group_name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "private_subnet" {
  value = azurerm_subnet.private-subnet.id
}

output "public_subnet" {
  value = azurerm_subnet.public-subnet.id
}

output "public_ip_id" {
  value = azurerm_public_ip.public-ip.id
}
