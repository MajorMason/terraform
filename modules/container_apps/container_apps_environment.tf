resource "azurerm_container_app_environment" "conapp-environment" {
  name = "${var.environment}-app-environment"
  location = var.location
  resource_group_name = "${var.environment}-rg"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-workspace

  tags = {
    environment = var.environment
  }
}
