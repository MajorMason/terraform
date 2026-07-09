#Having an explicit dependency prevents the resource group this VNET is tied to, from being deleted
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  location            = var.location
  resource_group_name = "${var.environment}-rg"
  address_space       = var.address_space

  tags = {
    environment = var.environment
  }
}
#In most cases, its better to deploy subnets separately from the VNET. In Azure, all subnets are private by default,
#and are only public when you attach a public IP to whatever resource you assign it to, then assign it to an NSG
resource "azurerm_subnet" "private-subnet" {
  name                 = "${var.environment}-private-subnet"
  resource_group_name  = "${var.environment}-rg"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.private_address_prefix
}

resource "azurerm_virtual_network_peering" "vnet-peer1to2" {
  name                      = "${var.environment}-vnet-peer1to2"
  resource_group_name       = "${var.environment}-rg"
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-monitor.id
}

#VNET & private subnet exclusively for Log Analytics to leverage via AMPLS
resource "azurerm_virtual_network" "vnet-monitor" {
  name = "${var.environment}-vnet-monitor"
  location = var.location
  resource_group_name = "${var.environment}-rg"
  address_space = var.address_space_monitor

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "private-subnet-monitor" {
  name                 = "${var.environment}-private-subnet-monitor"
  resource_group_name  = "${var.environment}-rg"
  virtual_network_name = azurerm_virtual_network.vnet-monitor.name
  address_prefixes     = var.private_address_prefix_monitor
}

resource "azurerm_virtual_network_peering" "vnet-peer2to1" {
  name                      = "${var.environment}-peer2to1"
  resource_group_name       = "${var.environment}-rg"
  virtual_network_name      = azurerm_virtual_network.vnet-monitor.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}
