#These module bocks below are being called upon by all of our "modules" files that contain
#the actual resources themselves such as resource group, vnet, keyvault, etc.
module "core_infra" {
  source               = "./modules/core_infra"
  name_prefix          = var.name_prefix
  environment          = var.environment
  location             = var.location
  keyvault             = var.keyvault
  keyvault_sku_name    = var.keyvault_sku_name
  storage_account_type = var.storage_account_type
}
