#Azure NSGs are stateful, and collapse both the ACLs and Security Groups into one
#Unlike AWS that has separate methods (used together) via ACLs and Security Groups,
#Azure only needs just NSGs and their rules (stateful only) to secure everything
resource "azurerm_network_security_group" "backend_nsg" {
  name = "${var.environment}-backend-nsg"
  location = var.location
  resource_group_name = "${var.environment}-rg"
}

#A Private Endpoint:
#-Gets its own NIC inside your subnet (this NIC is taken care of behind the scenes by Azure)
#-Has a private IP (e.g., 10.0.1.5)
#-Accepts traffic from any resource in the VNet
#-Ignores inbound NSG rules (Azure forces this behavior)
#-Can only be restricted using Private Endpoint Network Policies (but those only apply to outbound from the PE NIC, not inbound to it)
#We don't need any rules for Azure DNS resolver since its built in
resource "azurerm_network_security_rule" "sql_1433_nsr" {
  name                        = "sql-1433-allow"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = var.private_address_prefix[0]
  destination_address_prefix  = "Sql"
  resource_group_name         = "${var.environment}-rg"
  network_security_group_name = azurerm_network_security_group.backend_nsg.name
}
