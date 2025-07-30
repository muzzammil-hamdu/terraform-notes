variable "nic" {
 default = "nicname"
}
variable "ipconfigname" {
 default = "ipname"
}
resource "azurerm_network_interface" "example" {
 name = var.nic
 location = azurerm_resource_group.example.location
 resource_group_name = azurerm_resource_group.example.name
 ip_configuration {
 name = var.ipconfigname
 subnet_id = azurerm_subnet.example.id
 private_ip_address_allocation = "Dynamic"
 public_ip_address_id = azurerm_public_ip.example.id
 }
}
