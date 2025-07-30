variable "pip" {
 default = "pipname"
}
resource "azurerm_public_ip" "example" {
 name = var.pip
 resource_group_name = azurerm_resource_group.example.name
 location = azurerm_resource_group.example.location
 allocation_method = "Static"
}
