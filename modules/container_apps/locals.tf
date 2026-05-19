locals {
    container_apps = {
        conapp_api = {
            name = "${var.environment}-countysuite-api"
            container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
            resource_group_name = "${var.environment}-rg"
            revision_mode = var.revision_mode

        identity = {
            type = "SystemAssigned"
        }

        template = {
            container = {
                name = "${var.environment}-countysuite-api"
                image = "majormason/mysite:countysuite_api"
                cpu = var.container_cpu
                memory = var.container_memory
            env = {
                name  = "SQL_SERVER"
                value = "${var.environment}-sql.database.windows.net"
            }
        }
            custom_scale_rule = {
                name = "${var.environment}-api-scale-rule"
                custom_rule_type = "cpu"
                metadata = {
                    type = "Utilization"
                    value = "75"
            }
        }
        }
        ingress = {
            external_enabled = false
            target_port = var.conapp_api_port
            transport = "auto"
            allow_insecure_connections = false
            traffic_weight = {
                latest_revision = true
                percentage = var.conapp_api_traffic
            }
        }
    }

        conapp_prothonotary = {
            name = "${var.environment}-prothonotary-fe"
            container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
            resource_group_name = "${var.environment}-rg"
            revision_mode = var.revision_mode
#In the template below, we leverage an HTTPS URL that Azure provides for us, meaning we don't
#mess with any certs, the API is not exposed publicly, and all traffic stays in the conapp env boundary
            template = {
                container = {
                    name = "${var.environment}-prothonotary-fe"
                    image = "majormason/mysite:prothonotary_fe"
                    cpu = var.container_cpu
                    memory = var.container_memory
                env = {
                    name  = "API_BASE_URL"
                    value = "https://${var.environment}-countysuite-api.${azurerm_container_app_environment.conapp-environment.default_domain}"
                }
            }
#The metadata is predefined on what string names can be used here
                custom_scale_rule = {
                    name = "${var.environment}-fe-scale-rule"
                    custom_rule_type = "cpu"
                    metadata = {
                        type = "Utilization"
                        value = "80"
                    }
                }
            }
            ingress = {
                external_enabled = true
                target_port = var.conapp_prothonotary_port
                transport = "auto"
                fqdn = var.conapp_prothonotary_fqdn
                traffic_weight = {
                    latest_revision = true
                    percentage = var.conapp_prothonotary_traffic
                }
            }
        }
    
        conapp_sheriff = {
            name = "${var.environment}-sheriff-fe"
            container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
            resource_group_name = "${var.environment}-rg"
            revision_mode = var.revision_mode
  
            template = {
                container = {
                    name = "${var.environment}-sheriff-fe"
                    image = "majormason/mysite:sheriff_fe"
                    cpu = var.container_cpu
                    memory = var.container_memory
                env = {
                    name  = "API_BASE_URL"
                    value = "https://${var.environment}-countysuite-api.${azurerm_container_app_environment.conapp-environment.default_domain}"
                }
            }
                custom_scale_rule = {
                    name = "${var.environment}-fe-scale-rule"
                    custom_rule_type = "cpu"
                    metadata = {
                        type = "Utilization"
                        value = "80"
                    }
                }
            }
            ingress = {
                external_enabled = true
                target_port = var.conapp_sheriff_port
                transport = "auto"
                fqdn = var.conapp_sheriff_fqdn
                traffic_weight = {
                    latest_revision = true
                    percentage = var.conapp_sheriff_traffic
                }
            }
        }
    }
}
