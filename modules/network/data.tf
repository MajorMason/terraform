data "azurerm_subnet" "private-subnet" {
    name = "${var.environment}-log-workspace"
    resource_group_name = "${var.environment}-rg"
    virtual_network_name = "${var.environment}-vnet"
}

data "azurerm_mssql_server" "sql-server" {
    name = "${var.environment}-log-workspace"
    resource_group_name = "${var.environment}-rg"
}

data "azurerm_container_app" "conapp-be" {
    name = "${var.environment}-log-workspace"
    resource_group_name = "${var.environment}-rg"
}
