#This single client config data object provides access to all of its attributes: tenant_id, object_id, subscription_id, 
#client_id, etc. You can then reference those attributes as many times as you want in your main.tf file
data "azurerm_client_config" "current" {}
