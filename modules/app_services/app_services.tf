resource "azurerm_windows_web_app" "fe-webapp" {
  name = "${var.environment}-fe-webapp"
  resource_group_name = "${var.environment}-rg"
  location = var.location
  service_plan_id = azurerm_service_plan.service-plan.id


  site_config {
    always_on = var.always_on
    load_balancing_mode = var.load_balancing
    use_32_bit_worker = var.bit_worker
    
    application_stack {
        current_stack = var.current_stack
        dotnet_version = var.dotnet_version
    }
  }
}

resource "azurerm_windows_web_app" "be-webapp" {
  name = "${var.environment}-be-webapp"
  resource_group_name = "${var.environment}-rg"
  location = var.location
  service_plan_id = azurerm_service_plan.service-plan.id

  site_config {
    always_on = var.always_on_api
    load_balancing_mode = var.load_balancing
    use_32_bit_worker = var.bit_worker
  }

#The "value" string is the connection string itself
  connection_string {
    name = var.connection_string_name
    type = var.connection_string_type
    value = var.connection_string_value
  }
}
