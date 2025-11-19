#This Private Endpoint connects our Azure SQL Server to our VNET
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${var.environment}-azuresql"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  subnet_id           = data.azurerm_subnet.subnet.id

#The manual_connection boolean is set to false since we've not connecting to another tenant
#nor subscription in our use case
#Additionally, the private connection resource ID string is used instead of "alias" since we're
#targeting our own SQL Server in the same subscription (even with our multi-subscription setup)
  private_service_connection {
    name                              = "private_endpoint_azuresql"
    private_connection_resource_id    = azurerm_mssql_server.sql-server.id
    subresource_names                 = ["sqlServer"]
    is_manual_connection              = false
    request_message                   = "Connection established for Azure SQL Server."
  }

#The Private DNS Zone Group block below helps resolve the SQL FQDN to the private IP
#If you do not use this codeblock, then we'd have to manually configure a DNS record ourselves
  private_dns_zone_group {
    name                 = "azuresql_dns_zone_group"
    private_dns_zone_ids = [azurerm_private_dns_zone.azuresql_zone.id]
  }
}
