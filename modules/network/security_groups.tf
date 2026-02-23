#Azure NSGs are stateful, and collapse both the ACLs and Security Groups into one
#Unlike AWS that has separate methods (used together) via ACLs and Security Groups,
#Azure only needs just NSGs and their rules (stateful only) to secure everything
resource "azurerm_network_security_group" "frontend_nsg" {
  name = "${var.environment}-frontend-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "backend_nsg" {
  name = "${var.environment}-backend-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
}

#Since NSGs are stateful, you create inbound allow rules on the NSG attached to either:
#-the subnet hosting your container environment, or
#-the NIC of the compute resource (VM, Container Instance, etc.)
resource "azurerm_network_security_rule" "fe_80_nsr" {
  name                        = "fe-80-allow"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.frontend_nsg.name
}

resource "azurerm_network_security_rule" "fe_443_nsr" {
  name                        = "fe-443-allow"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.backend_nsg.name
}
