resource "azurerm_container_app" "conapp-be" {
  name = "${var.environment}-BE"
  container_app_environment_id = azurerm_container_app_environment.be-conapp-environment.id
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
#Transport set to auto or can be http depending on needs
    ingress {
      external_enabled = false
      target_port = 8080
      transport = "auto"
      allow_insecure_connections = false
      traffic_weight {
        latest_revision = true
        percentage = 100
      }
    }
}

#The autoscaling functionality is provided by KEDA (Kubernetes Event-Driven Autoscaling)
resource "azurerm_container_app" "conapp-fe" {
  name = "${var.environment}-FE"
  container_app_environment_id = azurerm_container_app_environment.fe-conapp-environment.id
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
      external_enabled = true
      target_port = var.conapp_fe_port
      transport = "auto"
      fqdn = var.conapp_fe_fqdn
      traffic_weight {
        latest_revision = true
        percentage = var.conapp_fe_traffic
      }
    }
}
