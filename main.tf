#When we create a module codeblock in our root "main.tf" file here, we are not creating the resource
#but instead we're calling the actual module we made (the main.tf file in the modules folder)
#and passing in the values. Hence why we have used "module" for the codeblock name and "source"
#Think of each module codeblock as the actual resource with all the same string names with the only
#exception being "source"
module "resource_group" {
  source      = "./modules/core_infra/main.tf"
  environment = var.environment
  location    = var.location
}

#Remember that string names like "vnet_name" is declared in the global variables.tf file
module "virtual_network" {
  source             = "./modules/core_infra/main.tf"
  environment        = var.environment
  location           = var.location
  vnet_name          = "${var.environment}-vnet"
  vnet_address_space = ["10.10.0.0/27"]
}
