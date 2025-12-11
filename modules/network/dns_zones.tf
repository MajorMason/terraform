#The DNS Zone "name" string must match the premade Microsoft Azure DNS name
#Microsoft's Azure team has a fixed list of DNS names to choose based off the resource

#Azure SQL DNS Zone & Link
resource "azurerm_private_dns_zone" "azuresql_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "azuresql_zone_vnet_link" {
  name                  = "azuresql_zone_vnet_link"
  resource_group_name   = "${var.environment}-rg"
  private_dns_zone_name = azurerm_private_dns_zone.azuresql_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

#Azure Container App Zone & Link
resource "azurerm_private_dns_zone" "conapp_be_zone" {
  name                = "privatelink.eastus.azurecontainerapps.io"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "conappbe_zone_vnet_link" {
  name                  = "conappbe_zone_vnet_link"
  resource_group_name   = "${var.environment}-rg"
  private_dns_zone_name = azurerm_private_dns_zone.conapp_be_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
