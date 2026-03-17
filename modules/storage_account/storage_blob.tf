#Due to the outdated VSCode linter, ignore the linting on the two storage container resources
#here for "storage_account_name" arguments
resource "azurerm_storage_container" "tfstate-storage-container" {
  name = "tfstate"
  storage_account_name = azurerm_storage_account.storage-account.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "tfvars-storage-container" {
  name = "tfvars"
  storage_account_name = azurerm_storage_account.storage-account.id
  container_access_type = "private"
}

#We will use Block blobs as the type because it rewrites the tfstate files in full
#each time there is an update
#NOTE: We do not need another storage blob resource for our tfvars files as they will be manually uploaded from the terminal
resource "azurerm_storage_blob" "tfstate-storage-blob" {
  name = "${var.environment}.tfstate"
  storage_account_name = azurerm_storage_account.storage-account.name
  storage_container_name = azurerm_storage_container.tfstate-storage-container.name
  type = "Block"
  source = "${var.environment}.tfstate"
}
