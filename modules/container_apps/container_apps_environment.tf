resource "azurerm_container_app_environment" "conapp-environment" {
  name = "${var.environment}-app-environment"
  location = var.location
  resource_group_name = "${var.environment}-rg"

  tags = {
    environment = var.environment
  }
}
