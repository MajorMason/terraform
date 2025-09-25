#A simple Linux VM on the cheapest available size from Azure offerings
#Note: Max Bid Price is the maximum price you're willing to pay for this VM (in USD) and if the bid
#price falls below the current spot price, the VM will be evicted automatically
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.environment}-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.vm_size
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.dev-nic.id]
  eviction_policy       = var.eviction_policy
  max_bid_price         = var.max_bid_price

  #Note that the file "customdata.tpl" is a template file indicated by the file extension "tpl"
  #Template files are very nice to pass in a series of commands for things like VMs
  custom_data = filebase64("customdata.tpl")

  #The key pair is being referenced using a Terraform function "file" in tandem with
  #parenthesis. This reads the devazurekey.pub file and substitutes the key value in the code,
  #just make sure to use forward slashing for the pathing
  #For creating the ssh key pair, we just used a simple "ssh-keygen -t rsa" cmd
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/devazurekey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = var.environment
  }
}
