#The private endpoints allow resources like our MSSQL Server and BE Conapp API to connect securely to our VNET and communicate with each other
resource "azurerm_private_endpoint" "private_endpoints" {
  for_each = local.private_endpoints

  name                = each.value.name
  location            = var.location
  resource_group_name = "${var.environment}-rg"
  subnet_id           = azurerm_subnet.private-subnet.id
#The private connection resource ID string is used instead of "alias" since we're targeting our own SQL Server in the same subscription (even with our multi-subscription setup)
#The manual_connection boolean is set to false since we've not connecting to another tenant, nor subscription in our use case
  private_service_connection {
    name                           = each.value.psc.name
    subresource_names              = each.value.psc.subresource_names
    private_connection_resource_id = each.value.psc.private_connection_resource_id
    is_manual_connection           = false
    request_message                = each.value.psc.request_message
  }
#The codeblock below helps resolve the SQL FQDN to the private IP and links it to our DNS zone
#If you do not use this codeblock, then we'd have to manually configure a DNS record ourselves
  private_dns_zone_group {
    name                 = each.value.private_dns_zone_group.name
    private_dns_zone_ids = [for zone in azurerm_private_dns_zone.dns_zones : zone.id]
  }

  tags = {
    environment = var.environment
  }
}

#AMPLS Resources for Log Analytics Workspace to securely use VNET Monitor
resource "azurerm_monitor_private_link_scope" "ampls" {
  name                = "${var.environment}-ampls"
  resource_group_name = "${var.environment}-rg"
}

resource "azurerm_monitor_private_link_scoped_service" "ampls-service" {
  name                = "${var.environment}-amplsservice"
  resource_group_name = "${var.environment}-rg"
  scope_name          = azurerm_monitor_private_link_scope.ampls.name
  linked_resource_id  = var.azurerm_log_analytics_workspace_id
}
