#The autoscaling functionality is provided by KEDA (Kubernetes Event-Driven Autoscaling)
resource "azurerm_container_app" "conapp-fe" {
  name = "${var.environment}-FE"
  container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
    resource_group_name = "${var.environment}-rg"
    revision_mode = var.revision_mode

    template {
      container {
        name = var.container_name_fe
        image = var.container_image
        cpu = var.container_cpu
        memory = var.container_memory
      }
#The metadata is predefined on what string names can be used here
      custom_scale_rule {
        name = "${var.environment}-fe-scale-rule"
        custom_rule_type = "cpu"
        metadata = {
          type = "Utilization"
          value = "80"
        }
      }
    }

    ingress {
      fqdn = var.conapp_fe_fqdn
      target_port = var.conapp_fe_port
      traffic_weight {
        latest_revision = true
        percentage = var.conapp_fe_traffic
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
        image = var.container_image
        cpu = var.container_cpu
        memory = var.container_memory
      }
    }
}
