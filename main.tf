#Resource Group module
module "resource_group" {
  source      = "./modules/resource_group"
  name        = "${var.environment}-rg"
  location    = var.location
  environment = var.environment
}

#Vnet module
#Remember that string names like "vnet_name" is declared in the modules' variables.tf file
module "virtual_network" {
  source             = "./modules/network"
  name               = "${var.environment}-vnet"
  location           = var.location
  vnet_name          = "${var.environment}-vnet"
  vnet_address_space = var.address_space
  environment        = var.environment
}

#Subnet module
module "subnet" {
  source                = "./modules/core_infra"
  name                  = "${var.environment}-subnet"
  location              = var.location
  subnet_name           = "${var.environment}-subnet"
  subnet_address_prefix = var.subnet_address_prefix
  environment           = var.environment
}

#Public IP module
module "public-ip" {
  source            = "./modules/core_infra"
  name              = "${var.environmnet}-public-ip"
  location          = var.location
  allocation_method = Static
  environment       = var.environment
}

#NIC module
module "nic" {
  source      = "./modules/core_infra/"
  name        = "${var.environment}-nic"
  location    = var.location
  environment = var.environment

  ip_configurations = [
    {
      name                          = "internal"
      subnet_id                     = azurerm_subnet.subnet_id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.public-ip.id
    }
  ]
}

#Virtual Machine module
module "virtual_machine" {
  source                = "./modules/core_infra/"
  name                  = "${var.environment}-vm"
  location              = var.location
  vm_size               = var.vm_size
  admin_username        = "adminuser"
  network_interface_ids = var.nic_ids[var.environment]
  eviction_policy       = var.eviction_policy
  max_bid_price         = var.max_bid_price
  customer_data         = filebase64("linux_template.tpl")

  admin_ssh_key = [
    {
      username   = "adminuser"
      public_key = file("~/.ssh/devazurekey.pub")
    }
  ]

  os_disk = [
    {
      caching              = "ReadWrite"
      storage_account_type = var.storage_account_type
    }
  ]

  source_image_reference = [
    {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "22.04-LTS"
      version   = "latest"
    }
  ]
}
