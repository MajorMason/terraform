output "rg_name" {
  value = var.resource_group_name
}

output "subnet_id" {
  value = azurerm_subnet.private-subnet.id
}

output "public_ip_id" {
  value = azurerm_public_ip.public-ip.id
}
