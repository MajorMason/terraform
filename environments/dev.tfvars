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

#SQL Server & DBs
sql_version = "12.0"
sql_login = "admin"
sql_pass = "@dm1n1$tr@tor"
entraid_login = "EntraID Admin"
object_id = "00000000"
license_type = "LicenseIncluded"
max_size_gb = 2
sql_sku_name = "Basic"
zone_redundant = false

#Service Plan & App Services
serviceplan_sku = "B1"
os_type = "Windows"
always_on = false
always_on_api = true
load_balancing = "WeightedRoundRobin"
current_stack = "dotnetcore"
dotnet_version = "v8.0"
connection_string_name = "ProthonotaryConnectionString"
connection_string_type = "SQLAzure"
connection_string_value = "Server=tcp:${azurerm_mssql_managed_instance.dev-sql.name}.database.windows.net,1433;Persist Security Info=False;User ID=county;Password=Suit35533;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Connection Timeout=100;"
