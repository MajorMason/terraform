data "azurerm_log_analytics_workspace" "log-workspace" {
  name                = "${var.environment}-log-workspace"
  resource_group_name = "${var.environment}-rg"
}
