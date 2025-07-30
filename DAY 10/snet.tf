variable "snetname" {
 default = "snettf"
 }
variable "saddressspace" {
 default = ["10.1.1.0/24"]
 type = list(string)
 }
resource "azurerm_subnet" "example" {
 name = var.snetname
 resource_group_name = azurerm_resource_group.example.name
 virtual_network_name = azurerm_virtual_network.example.name
 address_prefixes = var.saddressspace
}
