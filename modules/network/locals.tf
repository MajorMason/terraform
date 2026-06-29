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
}
#Azure automatically scans the list and auto-pairs the correct DNS Zone to the appropriate Private Endpoint
#via the endpoints' argument titled "subresource". This is how we can use the following logic in our private endpoints:
#for zone in azurerm_private_dns_zone.dns_zones : zone.id
