data "azurerm_mssql_server" "sql-server" {
    name = "${var.environment}-log-workspace"
    resource_group_name = "${var.environment}-rg"
}

data "azurerm_container_app" "conapp-be" {
    name = "${var.environment}-log-workspace"
    resource_group_name = "${var.environment}-rg"
}
