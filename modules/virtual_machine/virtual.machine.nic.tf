#If we used the dynamic allocation method, the terraform plan would show "known after apply"
#since Azure won't assign an IP until after its attached to a resource
resource "azurerm_public_ip" "public-ip" {
  name                = "${var.environment}-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
  }
}

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
