#The NIC to be used exclusively by the VM
resource "azurerm_network_interface" "nic" {
  name                = "${var.environment}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }

  tags = {
    environment = var.environment
  }
}
