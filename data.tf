#Data sources are a way to query items from the provider (AzureRM API) and use it in our code
data "azurerm_client_config" "current" {}

data "azurerm_public_ip" "dev-ip-data" {
  name                = azurerm_public_ip.dev-ip.name
  resource_group_name = azurerm_resource_group.dev-rg.name
}

#Run the command "terraform apply -refresh-only" to leverage the data source to display the data
data "azurerm_key_vault_secret" "dev-pass" {
  name         = "dev-pass"
  key_vault_id = var.keyvault_name
}

#Data sources for Private Endpoint configuration for our Azure SQL Server
#and our backend Container App
data "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  resource_group_name = data.azurerm_resource_group.vnet.name
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}
