#This code block uses an explicit dependency by using the ".name" at the end of the rsg name line
#This tells AzureRM that this VNET is dependent on the resource group "dev-rg"
#Having an explicit dependency prevents the resource group this VNET is tied to, from being deleted
resource "azurerm_virtual_network" "dev-vnet" {
  name                = "dev-network"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  address_space       = ["10.10.0.0/27"]

  tags = {
    environment = var.environment
  }
}

#In most cases, its better to deploy subnets separately from the VNET
resource "azurerm_subnet" "dev-subnet" {
  name                 = "dev-subnet"
  resource_group_name  = azurerm_resource_group.dev-rg.location
  virtual_network_name = azurerm_virtual_network.dev-vnet.name
  address_prefixes     = ["10.10.1.0/27"]
}

#NSGs enable or disable inbound/outbound traffic
resource "azurerm_network_security_group" "dev-nsg" {
  name                = "dev-nsg"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
}

#Associates an NSG with a subnet, and protects the subnet within the VNET
resource "azurerm_subnet_network_security_group_association" "dev-nsga" {
  subnet_id                 = azurerm_subnet.dev-subnet.id
  network_security_group_id = azurerm_network_security_group.dev-nsg.id
}

#If we used the dynamic allocation method, the terraform plan would show "known after apply"
#since Azure won't assign an IP until after its attached to a resource
resource "azurerm_public_ip" "dev-ip" {
  name                = "dev-ip"
  resource_group_name = azurerm_resource_group.dev-rg.name
  location            = azurerm_resource_group.dev-rg.location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "dev-nic" {
  name                = "dev-nic"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev-ip.id
  }

  tags = {
    environment = var.environment
  }
}
