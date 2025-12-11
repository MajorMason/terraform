resource "azurerm_storage_container" "storage-container" {
  name = "${var.environment}-storage-container"
  storage_account_name = azurerm_storage_account.storage-account
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storage-blob" {
  name = "${var.environment}.tfvars"
  storage_account_name = azurerm_storage_account.storage-account.name
  storage_container_name = azurerm_storage_container.storage-container.name
  type = "Block"
  source = "${var.environment}.tfvars"
}
