#This file is where we "assign" values for each specific environment, which works in conjunction
#with our global variables.tf file to provide for our root main.tf modules
#Never commit secrets to this file.

#General
environment = "prod"

#Virtual Machine
vm_name = "${var.environment}-vm"
storage_account_type = "Standard_LRS"
vm_size = "B2ts v2"
eviction_policy = "Deallocate"
max_bid_price = 9.10
admin_username = "adminuser"
custom_data = filebase64("linux_template.tpl")

#VNET
address_space = ["10.20.0.0/27"]

#Subnet
address_prefix = ["10.20.1.0/27"]

#Public IP
allocation_method = "Static"

#KeyVault
keyvault_name = "${var.environment}-keyvault"
keyvault_sku_name = "standard"

#Storage Account
account_kind = "BlobStorage"
account_tier = "Standard"
replication_type = "LRS"

#SQL Server & DBs
sql_version = "12.0"
sql_login = "admin"
sql_pass = "@dm1n1$tr@tor557322"
entraid_login = "EntraID Admin"
object_id = "00000000"
license_type = "LicenseIncluded"
max_size_gb = 10
sku_name = "S0"
zone_redundant = true
