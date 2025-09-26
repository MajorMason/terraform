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
  source = "./modules/keyvault"
  keyvault_name = var.keyvault_name
  keyvault_sku_name = var.keyvault_sku_name
 }
