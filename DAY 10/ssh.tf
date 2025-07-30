variable sshname{
default = "sshkey"
}
resource "azurerm_ssh_public_key" "example" {
 name = var.sshname
 location = azurerm_resource_group.example.location
 resource_group_name = azurerm_resource_group.example.name
 public_key = file("~/.ssh/id_rsa.pub")
}
