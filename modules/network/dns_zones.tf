#The DNS Zone "name" string must match the premade Microsoft Azure DNS name
#Microsoft's Azure team has a fixed list of DNS names to choose based off the resource

#Azure SQL DNS Zone & Link
resource "azurerm_private_dns_zone" "azuresql_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "${var.environment}-rg"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azuresql_zone_vnet_link" {
  name                  = "azuresql_zone_vnet_link"
  resource_group_name   = "${var.environment}-rg"
  private_dns_zone_name = azurerm_private_dns_zone.azuresql_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

#Azure Container App DNS Zone & Link
resource "azurerm_private_dns_zone" "conapp_api_zone" {
  name                = "privatelink.eastus.azurecontainerapps.io"
  resource_group_name = "${var.environment}-rg"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "conappbe_zone_vnet_link" {
  name                  = "conappapi_zone_vnet_link"
  resource_group_name   = "${var.environment}-rg"
  private_dns_zone_name = azurerm_private_dns_zone.conapp_api_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
