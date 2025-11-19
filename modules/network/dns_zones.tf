#The DNS Zone "name" string must match the premade Microsoft Azure DNS name
#Microsoft's Azure team has a fixed set list of DNS names to choose based off the resource
resource "azurerm_private_dns_zone" "azuresql_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_vnet_link" {
  name                  = "zone_vnet_link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.azuresql_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
