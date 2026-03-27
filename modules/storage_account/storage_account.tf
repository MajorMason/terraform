resource "azurerm_storage_account" "storage-account" {
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
