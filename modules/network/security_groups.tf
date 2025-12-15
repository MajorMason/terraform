resource "azurerm_network_security_group" "backend_nsg" {
  name = "backend-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
}

#The [0] at the end of the source and destination prefix strings simply tell Terraform
#to only supply the first item in said lists which is the network address itself
resource "azurerm_network_security_rule" "fe-be" {
  name = "${var.environment}-febe-internal-allow"
  resource_group_name = var.resource_group_name
  priority = 100
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "8080"
  source_address_prefix = var.public_address_prefix[0]
  destination_address_prefix = var.private_address_prefix[0]
  network_security_group_name = azurerm_network_security_group.backend_nsg
}
