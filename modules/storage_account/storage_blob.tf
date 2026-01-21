resource "azurerm_storage_container" "storage-container" {
  name = "tfstate"
  storage_account_name = azurerm_storage_account.storage-account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storage-blob" {
  name = "${var.environment}.tfvars"
  storage_account_name = azurerm_storage_account.storage-account.name
  storage_container_name = azurerm_storage_container.storage-container.name
  type = "Block"
  source = "${var.environment}.tfvars"
}
