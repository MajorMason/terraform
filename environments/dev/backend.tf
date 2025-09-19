#This file allows us to store our Terraform state file in a secure location, namely
#an Azure storage account, as denoted below
terraform {
  backend "azurerm" {
    resource_group_name = "dev-rg-terraform-state"
    storage_account_name = "statestorage"
    container_name = "tfstate"
    key = "dev.terraform.tfstate"
  }
}
#The key is out unique state file
