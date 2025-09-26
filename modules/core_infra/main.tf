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
  address_space       = var.address_space

  tags = {
    environment = var.environment
  }
}

#In most cases, its better to deploy subnets separately from the VNET
resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefix
}
