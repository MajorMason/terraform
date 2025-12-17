#Resource Group module
#NOTE: We need the actual resource group referenced here since we're unable to point to the module
resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-rg"
  location = var.location
}

#Network module
#Contains: Vnet, Subnet, Public IP, DNS Zones
module "virtual_network" {
  source                 = "./modules/network"
  resource_group_name    = data.azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  vnet_name              = var.vnet_name
  address_space          = var.address_space
  environment            = var.environment
  subnet_name            = var.subnet_name
  private_address_prefix = var.private_address_prefix
  public_address_prefix  = var.public_address_prefix
  allocation_method      = "Static"
}

#Keyvault
module "keyvault" {
  source              = "./modules/keyvault"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  keyvault_name       = var.keyvault_name
  keyvault_sku_name   = var.keyvault_sku_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

#Storage Account
module "storage_account" {
  source           = "./modules/storage_account"
  account_kind     = var.account_kind
  account_tier     = var.account_tier
  replication_type = var.replication_type
}

#SQL Server & DBs
module "sql_server" {
  source         = "./modules/sql_server"
  sql_version    = var.sql_version
  sql_login      = var.sql_login
  sql_pass       = var.sql_pass
  entraid_login  = var.entraid_login
  object_id      = var.object_id
  license_type   = var.license_type
  max_size_gb    = var.max_size_gb
  sql_sku_name   = var.sql_sku_name
  zone_redundant = var.zone_redundant
  sql_lock       = var.sql_lock
}

#Container Apps & Environment
module "container_apps" {
  source           = "./modules/container_apps"
  revision_mode    = var.revision_mode
  container_cpu    = var.container_cpu
  container_memory = var.container_memory
  #CountySuite API
  conapp_be_image   = var.conapp_be_image
  conapp_be_port    = var.conapp_be_port
  conapp_be_traffic = var.conapp_be_traffic
  #Prothonotary FE
  conapp_fe_image   = var.conapp_fe_image
  conapp_fe_fqdn    = var.conapp_fe_fqdn
  conapp_fe_port    = var.conapp_fe_port
  conapp_fe_traffic = var.conapp_fe_traffic
  #Sheriff FE
  sheriff_fe_image       = var.sheriff_fe_image
  conapp_sheriff_fqdn    = var.conapp_sheriff_fqdn
  conapp_sheriff_port    = var.conapp_sheriff_port
  conapp_sheriff_traffic = var.conapp_sheriff_traffic
}

#Monitoring
module "log_analytics_workspace" {
  source                     = "./modules/monitoring"
  retention                  = var.retention
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-workspace.id
}
