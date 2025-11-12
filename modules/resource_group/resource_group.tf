#The resource group helps to contain our resources based off location,
#and can be categorized using the environment tag
#All our resources are using the reference name "rg" in their rsg name lines
resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}
