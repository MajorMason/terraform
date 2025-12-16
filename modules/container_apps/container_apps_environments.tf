#Container app environment for our backend API container apps only
#NOTE: Even for our backend conapp environment resource, we still need to use infra subnet ID string
resource "azurerm_container_app_environment" "be-conapp-environment" {
  name = "${var.environment}-be-app-environment"
  location = var.location
  resource_group_name = "${var.environment}-rg"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-workspace.id
  infrastructure_subnet_id = data.azurerm_subnet.private_subnet_id.id

  tags = {
    environment = var.environment
  }
}

#Container app environment for our frontend container apps only
resource "azurerm_container_app_environment" "fe-conapp-environment" {
  name = "${var.environment}-fe-app-environment"
  location = var.location
  resource_group_name = "${var.environment}-rg"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-workspace
  infrastructure_subnet_id = data.azurerm_subnet.public_subnet_id.id

  tags = {
    environment = var.environment
  }
}
