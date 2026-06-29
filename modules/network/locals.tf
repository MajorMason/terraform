locals {
    dns_zones = {
        azuresql_zone = {
            name = "privatelink.database.windows.net"
        }
        conapp_api_zone = {
            name = "privatelink.eastus.azurecontainerapps.io"
        }
    }
    vnet_links = {
        azuresql_zone_vnet_link = {
            name = "azuresql_zone_vnet_link"
            private_dns_zone_name = azurerm_private_dns_zone.dns_zones
        }
        conappbe_zone_vnet_link = {
            name = "conappapi_zone_vnet_link"
            private_dns_zone_name = azurerm_private_dns_zone.dns_zones
        }
    }
#Terraform treats our locals as plain maps, and as such, the keys like "private_service_connection" can be shortened to just "psc"
    private_endpoints = {
        pe_azuresql = {
            name = "${var.environment}-pe-azuresql"
            psc = {
                name                           = "private_endpoint_azuresql"
                subresource_names              = ["sqlServer"]
                private_connection_resource_id = var.azurerm_mssql_server_id
                request_message                = "Connection established for Azure SQL Server."
            }
            private_dns_zone_group = {
                name = "azuresql_dns_zone_group"
            }
        }
        pe_conapp_api = {
            name = "${var.environment}-pe-conapp-api"
            psc = {
                name                           = "private_endpoint_conapp_api"
                subresource_names              = ["containerapps"]
                private_connection_resource_id = var.azurerm_container_app_id
                request_message = "Connection incoming from ContainerApp-API"
            }
            private_dns_zone_group = {
                name = "conapp_api_dns_zone_group"
            }
        }
    }
}
#Azure automatically scans the list and auto-pairs the correct DNS Zone to the appropriate Private Endpoint
#via the endpoints' argument titled "subresource". This is how we can use the following logic in our private endpoints:
#for zone in azurerm_private_dns_zone.dns_zones : zone.id
