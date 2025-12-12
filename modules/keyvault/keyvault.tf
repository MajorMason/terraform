#Ensure that the Entra ID account Terraform is running under has rights to the secrets
#You can use either an MI or a Service Principal (but an MI is simpler long term)
resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.environment}-keyvault"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.keyvault_sku_name
#The "current" portion of the data object is just a Terraform label
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]
  }

  tags = {
    environment = var.environment
  }
}
#NOTE: Once purge protection is enabled, its impossible to disable it, deleting the keyvault
#with purge protection enabled will schedule it for standard deletion in 90 days
