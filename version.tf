#Azure Provider allows us to configure the Azure infrastructure using the AzureRM API
#Think of the provider as a plugin that interacts between the Terraform config and the APIs of Azure
#Try to keep your provider on the latest version to squash bugs as necessary
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

#This block below specifies the configuration for AzureRM and features
provider "azurerm" {
  features {
    key_vault {
      recover_soft_deleted_key_vaults = false
    }
  }
}
