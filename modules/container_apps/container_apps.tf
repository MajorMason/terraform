resource "azurerm_container_app" "conapp-api" {
  name = "${var.environment}-countysuite-api"
  container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
  resource_group_name = "${var.environment}-rg"
  revision_mode = var.revision_mode
#We use SystemAssigned Entra ID identity type because we want it to be lifecycle managed
#with least privilege, and doesn't require extra resources unlike UserAssigned
#The identity nested block will also auto-generate the service principle in Entra ID for us
    identity {
      type = "SystemAssigned"
    }
    template {
      container {
        name = azurerm_container_app.conapp-api.name
        image = "majormason/mysite:countysuite_api"
        cpu = var.container_cpu
        memory = var.container_memory
        env {
          name  = "SQL_SERVER"
          value = "${var.environment}-sql.database.windows.net"
        }
      }
      custom_scale_rule {
        name = "${var.environment}-api-scale-rule"
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
      environment = var.environment
    }
}

#The autoscaling functionality is provided by KEDA (Kubernetes Event-Driven Autoscaling)
resource "azurerm_container_app" "conapp-prothonotary" {
  name = "${var.environment}-prothonotary-fe"
  container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
  resource_group_name = "${var.environment}-rg"
  revision_mode = var.revision_mode
#In the template below, we leverage an HTTPS URL that Azure provides for us, meaning we don't
#mess with any certs, the API is not exposed publicly, and all traffic stays in the conapp env boundary
    template {
      container {
        name = azurerm_container_app.conapp-prothonotary.name
        image = "majormason/mysite:prothonotary_fe"
        cpu = var.container_cpu
        memory = var.container_memory
        env {
          name  = "API_BASE_URL"
          value = "https://${var.environment}-countysuite-api.${azurerm_container_app_environment.conapp-environment.default_domain}"
        }
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
      environment = var.environment
    }
}

resource "azurerm_container_app" "conapp-sheriff" {
  name = "${var.environment}-sheriff-fe"
  container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
  resource_group_name = "${var.environment}-rg"
  revision_mode = var.revision_mode
  
    template {
      container {
        name = azurerm_container_app.conapp-sheriff.name
        image = "majormason/mysite:sheriff_fe"
        cpu = var.container_cpu
        memory = var.container_memory
        env {
          name  = "API_BASE_URL"
          value = "https://${var.environment}-countysuite-api.${azurerm_container_app_environment.conapp-environment.default_domain}"
        }
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
      environment = var.environment
    }
}
