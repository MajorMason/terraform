output "azurerm_container_app_id" {
  value = "${var.environment}-countysuite-api"
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.conapp-environment.id
}
