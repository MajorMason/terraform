resource "azurerm_storage_share" "file_share" {
  name               = "${var.environment}-file-share"
  storage_account_name = azurerm_storage_account.storage-account.name
  quota              = 50
}
