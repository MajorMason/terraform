resource "azurerm_service_plan" "service-plan" {
  name = "${var.environment}-serviceplan"
  resource_group_name = "${var.environment}-rg"
  location = var.location
  sku_name = var.serviceplan_sku
  os_type = var.os_type

  tags = {
    environment = var.environment
  }
}
