#Ensure that the Entra ID account Terraform is running under has rights to the secrets
#You can use either an MI or a Service Principal (but an MI is simpler long term)
resource "azurerm_key_vault" "dev-keyvault" {
  name                        = "dev-keyvault"
  location                    = azurerm_resource_group.dev-rg.location
  resource_group_name         = azurerm_resource_group.dev-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.keyvault.sku.name

  access_policy = {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permission = [
      "Get",
    ]
  }
}
#NOTE: Once purge protection is enabled, its impossible to disable it, deleting the keyvault
#with purge protection enabled will schedule it for standard deletion in 90 days
