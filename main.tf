#Resource Group module
module "resource_group" {
  source      = "./modules/resource_group"
  name        = "${var.environment}-rg"
  location    = var.location
  environment = var.environment
}

#Network module
#Contains: Vnet, Subnet, Public IP
module "virtual_network" {
  source            = "./modules/network"
  location          = var.location
  vnet_name         = "${var.environment}-vnet"
  address_space     = var.address_space
  environment       = var.environment
  subnet_name       = "${var.environment}-subnet"
  address_prefix    = var.address_prefix
  allocation_method = Static
}

#Virtual Machine module
module "virtual_machine" {
  source                = "./modules/virtual_machine"
  vm_name               = "${var.environment}-vm"
  location              = var.location
  vm_size               = var.vm_size
  admin_username        = "adminuser"
  network_interface_ids = var.nic_ids[var.environment]
  eviction_policy       = var.eviction_policy
  max_bid_price         = var.max_bid_price
  custom_data           = filebase64("linux_template.tpl")
  storage_account_type  = var.storage_account_type
}

#Keyvault
module "keyvault" {
  source            = "./modules/keyvault"
  keyvault_name     = var.keyvault_name
  keyvault_sku_name = var.keyvault_sku_name
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
}

#Service Plan & App Service
module "app_services" {
  source                  = "./modules/app_services"
  serviceplan_sku         = var.serviceplan_sku
  os_type                 = var.os_type
  always_on               = var.always_on
  always_on_api           = var.always_on_api
  load_balancing          = var.load_balancing
  bit_worker              = var.bit_worker
  current_stack           = var.current_stack
  dotnet_version          = var.dotnet_version
  connection_string_name  = var.connection_string_name
  connection_string_type  = var.connection_string_type
  connection_string_value = var.connection_string_value
}
