#This file allows us to store our Terraform state files in a secure location, namely
#an Azure storage account, as denoted below
#Our ADO build pipeline will leverage this entirely, and pass in specific settings
#as if we ran it from our VSCode via "terraform init" which is pretty cool
terraform {
  backend "azurerm" {}
}

# Dev environment preview (what's done at the pipeline)
#NOTE: Required information includes storage account name, container name, and key

#terraform init \
#  -backend-config="resource_group_name=rg-dev" \
#  -backend-config="storage_account_name=devstorage" \
#  -backend-config="container_name=tfstate" \
#  -backend-config="key=dev.tfstate"
