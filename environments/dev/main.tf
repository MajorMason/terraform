#The resource groups help to contain our resources based off location,
#and can be categorized using the environment tag
resource "azurerm_resource_group" "dev-rg" {
  name     = "dev-resource-group"
  location = "East US"
  
  tags = {
    environment = var.environment
  }
}
