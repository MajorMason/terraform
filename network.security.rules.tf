#We put out NSG rules here to keep the networking.tf file clean
#The source address prefix would you your public IP address you want to allow inbound
resource "azurerm_network_security_rule" "dev-allow-inbound" {
  name                        = "dev-allow-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.dev-rg.name
  network_security_group_name = azurerm_network_security_group.dev-nsg.name
}
