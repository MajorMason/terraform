#The resource group helps to contain our resources based off location,
#and can be categorized using the environment tag
#All our resources are using the reference name "rg" in their rsg name lines
resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

#This code block uses an explicit dependency by using the ".name" at the end of the rsg name line
#This tells AzureRM that this VNET is dependent on the resource group reference name "rg"
#Having an explicit dependency prevents the resource group this VNET is tied to, from being deleted
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.10.0.0/27"]

  tags = {
    environment = var.environment
  }
}

#In most cases, its better to deploy subnets separately from the VNET
resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/27"]
}

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
