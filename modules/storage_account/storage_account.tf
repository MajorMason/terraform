resource "azurerm_storage_account" "storage-account" {
    name = "tfstateaccount"
    resource_group_name = "tfstate"
    location = var.location
    account_kind = var.account_kind
    account_tier = var.account_tier
    account_replication_type = var.replication_type

    tags = {
      environment = "tfstate"
    }
}
