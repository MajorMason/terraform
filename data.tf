#This single data object provides access to all of its attributes: tenant_id, object_id, subscription_id, 
#client_id, etc. You can then reference those attributes as many times as you want in your main.tf file
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = "${var.environment}-rg"
}

data "azurerm_mssql_server" "sql-server" {
  name                = "${var.environment}-sql"
  resource_group_name = "${var.environment}-rg"
}

data "azurerm_log_analytics_workspace" "log-workspace" {
  name                = "${var.environment}-log-workspace"
  resource_group_name = "${var.environment}-rg"
}
