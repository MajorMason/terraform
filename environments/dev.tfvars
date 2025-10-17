#This file is where we "assign" values for each specific environment, which works in conjunction
#with our global variables.tf file to provide for our root main.tf modules
#Never commit secrets to this file.

#General
environment = "dev"

#Virtual Machine
vm_name = "${var.environment}-vm"
storage_account_type = "Standard_LRS"
vm_size = "B2pts v2"
eviction_policy = "Delete"
max_bid_price = 7.30
admin_username = "adminuser"
custom_data = filebase64("linux_template.tpl")

#VNET
address_space = ["10.10.0.0/28"]

#Subnet
address_prefix = ["10.10.1.0/28"]

#Public IP
allocation_method = "Static"

#KeyVault
keyvault_name = "${var.environment}-keyvault"
keyvault_sku_name = "standard"

#Storage Account
account_kind = "BlobStorage"
account_tier = "Standard"
replication_type = "LRS"
