resource "azurerm_log_analytics_workspace" "log-workspace" {
  name                = "${var.environment}-log-workspace"
  location            = var.location
  resource_group_name = "${var.environment}-rg"
  sku                 = "PerGB2018"
  retention_in_days   = var.retention

  tags = {
    environment = "${var.environment}"
  }
}
