#The resource groups help to contain our resources based off location,
#and can be categorized using the environment tag
resource "azurerm_resource_group" "rg" {
  name     = "${var.name_prefix}-${var.environment}-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

#This code block uses an explicit dependency by using the ".name" at the end of the rsg name line
#This tells AzureRM that this VNET is dependent on the resource group "dev-rg"
#Having an explicit dependency prevents the resource group this VNET is tied to, from being deleted
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name_prefix}-${var.environment}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.10.0.0/27"]

  tags = {
    environment = var.environment
  }
}

#In most cases, its better to deploy subnets separately from the VNET
resource "azurerm_subnet" "subnet" {
  name                 = "${var.name_prefix}-${var.environment}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/27"]
}
