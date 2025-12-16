data "azurerm_log_analytics_workspace" "log-workspace" {
  name                = "${var.environment}-log-workspace"
  resource_group_name = "${var.environment}-rg"
}

data "azurerm_subnet" "private_subnet" {
  name                 = "${var.environment}-private-subnet"
  resource_group_name  = "${var.environment}-rg"
  virtual_network_name = "${var.environment}-vnet"
}

data "azurerm_subnet" "public_subnet" {
  name                 = "${var.environment}-public-subnet"
  resource_group_name  = "${var.environment}-rg"
  virtual_network_name = "${var.environment}-vnet"
}
