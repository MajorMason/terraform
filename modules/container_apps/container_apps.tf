resource "azurerm_container_app" "conapp-fe" {
  name = "${var.environment}-FE"
  container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
    resource_group_name = "${var.environment}-rg"
    revision_mode = var.revision_mode

    template {
      container {
        name = var.container_name_fe
        image = var.container_image_url
        cpu = var.container_cpu
        memory = var.container_memory
      }
    }
}

resource "azurerm_container_app" "conapp-be" {
  name = "${var.environment}-BE"
  container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
    resource_group_name = "${var.environment}-rg"
    revision_mode = var.revision_mode

    template {
      container {
        name = var.container_name_be
        image = var.container_image_url
        cpu = var.container_cpu
        memory = var.container_memory
      }
    }
}
