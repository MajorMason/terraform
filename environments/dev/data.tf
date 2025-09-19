#Data sources are a way to query items from the provider (AzureRM API) and use it in our code
data "azurerm_client_config" "current" {}

data "azurerm_public_ip" "dev-ip-data" {
  name                = azurerm_public_ip.dev-ip.name
  resource_group_name = azurerm_resource_group.dev-rg.name
}

#Run the command "terraform apply -refresh-only" to leverage the data source to display the data
data "azurerm_key_vault_secret" "dev-pass" {
  name         = "dev-pass"
  key_vault_id = var.keyvault
}
