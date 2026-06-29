#Network module
#Contains: Vnet, Subnet, Public IP, DNS Zones
module "virtual_network" {
  source                   = "./modules/network"
  location                 = var.location
  vnet_name                = var.vnet_name
  address_space            = var.address_space
  environment              = var.environment
  subnet_name              = var.subnet_name
  private_address_prefix   = var.private_address_prefix
  azurerm_mssql_server_id  = var.azurerm_mssql_server_id
  azurerm_container_app_id = var.azurerm_container_app_id
}

#Keyvault
module "keyvault" {
  source            = "./modules/keyvault"
  location          = var.location
  keyvault_name     = var.keyvault_name
  keyvault_sku_name = var.keyvault_sku_name
  tenant_id         = data.azurerm_client_config.current.tenant_id
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

#Container Apps
module "container_apps" {
  source                     = "./modules/container_apps"
  revision_mode              = var.revision_mode
  container_cpu              = var.container_cpu
  container_memory           = var.container_memory
  log_analytics_workspace_id = var.log_analytics_workspace_id
  infrastructure_subnet_id   = var.infrastructure_subnet_id
  traffic_weight             = var.traffic_weight
  #CountySuite API
  conapp_api_port = var.conapp_api_port
  #Prothonotary FE
  conapp_prothonotary_port = var.conapp_prothonotary_port
  conapp_prothonotary_fqdn = var.conapp_prothonotary_fqdn
  #Sheriff FE
  conapp_sheriff_fqdn = var.conapp_sheriff_fqdn
  conapp_sheriff_port = var.conapp_sheriff_port
}

#Monitoring
module "log_analytics_workspace" {
  source    = "./modules/monitoring"
  retention = var.retention
}
