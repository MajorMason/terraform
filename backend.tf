#This file allows us to store our Terraform state file in a secure location, namely
#an Azure storage account, as denoted below
#NOTE: Required information includes storage account name, container name, and key
terraform {
  backend "azurerm" {
    tenant_id                        = "000000"
    client_id                        = "000000"
    oidc_azure_service_connection_id = "000000"
    use_oidc                         = true
    use_azuread_auth                 = true
    storage_account_name             = "statestorage"
    container_name                   = "tfstate"
    key                              = "dev.terraform.tfstate"
  }
}
#The "client_id" is the client ID value of the SP, App Reg, or MI set aside for Terraform to use
#The "oidc_azure_service_connection_id" value is the service connection value from the settings
#page within ADO itself, and is generated automatically in ADO when you set that up
#The "key" is just the name of the blob file that we'll write the TF state info into
