#The DNS Zone "name" string must match the premade Microsoft Azure DNS name
#Microsoft's Azure team has a fixed list of DNS names to choose based off the resource
#Azure SQL + BE Conapp DNS Zone & Link
resource "azurerm_private_dns_zone" "dns_zones" {
  for_each = local.dns_zones

  name                = each.value.name
  resource_group_name = "${var.environment}-rg"
  tags = {
    environment = var.environment
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  for_each = local.vnet_links

  name                  = each.value.name
  resource_group_name   = "${var.environment}-rg"
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = each.value.virtual_network_id
}
