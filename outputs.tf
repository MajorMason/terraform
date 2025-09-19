#Outputs expose important attributes of the created resources such as rg name or ID
#Below we are leveraging an interpolation syntax with the dollar sign plus curly braces
output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.dev-vm.name}: ${data.azurerm_public_ip.dev-ip-data.ip_address}"
}

output "name" {
  value = data.azurerm_key_vault_secret.dev-pass.value
}
