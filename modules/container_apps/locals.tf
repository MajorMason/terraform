locals {
    container_apps = {
        conapp_api = {
            name = "${var.environment}-countysuite-api"
        identity = {
            type = "SystemAssigned"
        }
        template = {
            container = {
                name = "${var.environment}-countysuite-api"
                image = "majormason/mysite:countysuite_api"
            env = {
                name  = "SQL_SERVER"
                value = "Server=tcp:${var.environment}-sql.database.windows.net,1433;Initial Catalog=${var.db_name};User ID=${var.db_user};Password=${var.db_password};Encrypt=True;"
            }
        }
            custom_scale_rule = {
                name = "${var.environment}-api-scale-rule"
                metadata = {
                    type = "Utilization"
                    value = "75"
            }
        }
        }
        ingress = {
            external_enabled = false
            target_port = var.conapp_api_port
            allow_insecure_connections = false
        }
    }
#In the template below, we leverage an HTTPS URL that Azure provides for us, meaning we don't
#mess with any certs, the API is not exposed publicly, and all traffic stays in the conapp env boundary
        conapp_prothonotary = {
            name = "${var.environment}-prothonotary-fe"
            template = {
                container = {
                    name = "${var.environment}-prothonotary-fe"
                    image = "majormason/mysite:prothonotary_fe"
                env = {
                    name  = "API_BASE_URL"
                    value = "https://${var.environment}-countysuite-api.${azurerm_container_app_environment.conapp-environment.default_domain}"
                }
            }
#The metadata is predefined on what string names can be used here for our scaling rule
                custom_scale_rule = {
                    name = "${var.environment}-fe-scale-rule"
                    metadata = {
                        type = "Utilization"
                        value = "80"
                    }
                }
            }
            ingress = {
                external_enabled = true
                target_port = var.conapp_prothonotary_port
                fqdn = var.conapp_prothonotary_fqdn
            }
        }

        conapp_sheriff = {
            name = "${var.environment}-sheriff-fe"
            template = {
                container = {
                    name = "${var.environment}-sheriff-fe"
                    image = "majormason/mysite:sheriff_fe"
                env = {
                    name  = "API_BASE_URL"
                    value = "https://${var.environment}-countysuite-api.${azurerm_container_app_environment.conapp-environment.default_domain}"
                }
            }
                custom_scale_rule = {
                    name = "${var.environment}-fe-scale-rule"
                    metadata = {
                        type = "Utilization"
                        value = "80"
                    }
                }
            }
            ingress = {
                external_enabled = true
                target_port = var.conapp_sheriff_port
                fqdn = var.conapp_sheriff_fqdn
            }
        }
    }
}
