resource "azurerm_container_app" "conapp-api" {
  name = "${var.environment}-countysuite-api"
  container_app_environment_id = azurerm_container_app_environment.be-conapp-environment.id
  resource_group_name = "${var.environment}-rg"
  revision_mode = var.revision_mode

    template {
      container {
        name = azurerm_container_app.conapp-api.name
        image = var.countysuite_api_image
        cpu = var.container_cpu
        memory = var.container_memory
      }
      custom_scale_rule {
        name = "${var.environment}-fe-scale-rule"
        custom_rule_type = "cpu"
        metadata = {
          type = "Utilization"
          value = "75"
        }
      }
    }
#Transport set to auto or can be http depending on needs
    ingress {
      external_enabled = false
      target_port = var.conapp_api_port
      transport = "auto"
      allow_insecure_connections = false
      traffic_weight {
        latest_revision = true
        percentage = var.conapp_api_traffic
      }
    }

    tags = {
      environment = "${var.environment}"
    }
}

#The autoscaling functionality is provided by KEDA (Kubernetes Event-Driven Autoscaling)
resource "azurerm_container_app" "conapp-prothonotary" {
  name = "${var.environment}-prothonotary-fe"
  container_app_environment_id = azurerm_container_app_environment.fe-conapp-environment.id
  resource_group_name = "${var.environment}-rg"
  revision_mode = var.revision_mode

    template {
      container {
        name = azurerm_container_app.conapp-prothonotary.name
        image = var.prothonotary_fe_image
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
      target_port = var.conapp_prothonotary_port
      transport = "auto"
      fqdn = var.conapp_prothonotary_fqdn
      traffic_weight {
        latest_revision = true
        percentage = var.conapp_prothonotary_traffic
      }
    }

    tags = {
      environment = "${var.environment}"
    }
}

resource "azurerm_container_app" "conapp-sheriff" {
  name = "${var.environment}-sheriff-fe"
  container_app_environment_id = azurerm_container_app_environment.fe-conapp-environment.id
  resource_group_name = "${var.environment}-rg"
  revision_mode = var.revision_mode
  
    template {
      container {
        name = azurerm_container_app.conapp-sheriff.name
        image = var.sheriff_fe_image
        cpu = var.container_cpu
        memory = var.container_memory
      }
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
      target_port = var.conapp_sheriff_port
      transport = "auto"
      fqdn = var.conapp_sheriff_fqdn
      traffic_weight {
        latest_revision = true
        percentage = var.conapp_sheriff_traffic
      }
    }

    tags = {
      environment = "${var.environment}"
    }
}
