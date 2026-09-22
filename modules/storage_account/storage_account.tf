resource "azurerm_storage_account" "tf-storage-account" {
    name = "terraform"
    resource_group_name = "terraform-rg"
    location = var.location
    account_kind = var.account_kind
    account_tier = var.account_tier
    account_replication_type = var.replication_type
    shared_access_key_enabled = false

    tags = {
      environment = "terraform"
    }
}

resource "azurerm_storage_account" "storage-account" {
    name = "persistentfileshare"
    resource_group_name = "${var.environment}-rg"
    location = var.location
    account_kind = var.account_kind
    account_tier = var.account_tier
    account_replication_type = var.replication_type
    shared_access_key_enabled = false

    tags = {
      environment = var.environment
    }
}

resource "azurerm_container_app_environment_storage" "env-storage-link" {
  name                         = "env-storage-link"
  container_app_environment_id = var.container_app_environment_id
  access_key                   = "access_key"
  account_name                 = azurerm_storage_account.storage-account.name
  share_name                   = azurerm_storage_share.file_share.name
  access_mode                  = "ReadWrite"
}
