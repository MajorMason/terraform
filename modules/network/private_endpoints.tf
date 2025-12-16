#This Private Endpoint connects our Azure SQL Server to our VNET
#Only PaaS resources can leverage private endpoints
resource "azurerm_private_endpoint" "pe_azuresql" {
  name                = "${var.environment}-pe-azuresql"
  location            = var.location
  resource_group_name = "${var.environment}-rg"
  subnet_id           = azurerm_subnet.private-subnet.id

#The private connection resource ID string is used instead of "alias" since we're
#targeting our own SQL Server in the same subscription (even with our multi-subscription setup)
#Since we're consuming the Azure PaaS privately anyways, we just need Private Endpoints (like below)
#instead of leveraging a private service link (PLS), which is only needed if other tenants or VNets want to connect to it
#The manual_connection boolean is set to false since we've not connecting to another tenant
#nor subscription in our use case
  private_service_connection {
    name                              = "private_endpoint_azuresql"
    subresource_names                 = ["sqlServer"]
    private_connection_resource_id = data.azurerm_mssql_server.sql-server.id
    is_manual_connection              = false
    request_message                   = "Connection established for Azure SQL Server."
  }

#The codeblock below helps resolve the SQL FQDN to the private IP and links it to our DNS zone
#If you do not use this codeblock, then we'd have to manually configure a DNS record ourselves
  private_dns_zone_group {
    name                 = "azuresql_dns_zone_group"
    private_dns_zone_ids = [azurerm_private_dns_zone.azuresql_zone.id]
  }
}

#This Private Endpoint connects our backend container app to our VNET
resource "azurerm_private_endpoint" "pe_conapp_be" {
  name                = "${var.environment}-pe-conapp-be"
  location            = var.location
  resource_group_name = "${var.environment}-rg"
  subnet_id           = azurerm_subnet.private-subnet.id

  private_service_connection {
    name                           = "private_endpoint_conapp_be"
    subresource_names              = ["managedEnvironments"]
    private_connection_resource_id = data.azurerm_container_app.conapp-be.id
    is_manual_connection           = false
    request_message = "Connection incoming from ContainerApp-BE"
  }

  private_dns_zone_group {
    name                 = "conapp_be_dns_zone_group"
    private_dns_zone_ids = [azurerm_private_dns_zone.conapp_be_zone.id]
  }
}
