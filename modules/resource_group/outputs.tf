#Outputs are necessary because modules cannot directly see each other’s resources
#You must output values from one module and pass them as variables into another
#This is especially true when calling upon modules from the root main.tf
output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}
