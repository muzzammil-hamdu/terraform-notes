variable "vnetname" {
 default = "vanettf"
}
variable "addressapce" {
 default = ["10.1.0.0/16"]
 type = list(string)
}
resource "azurerm_virtual_network" "example" {
 name = var.vnetname
 resource_group_name = azurerm_resource_group.example.name
 location = var.location
 address_space = var.addressspace
}
