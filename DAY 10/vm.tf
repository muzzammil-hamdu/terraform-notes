variable "vmname" {
 default = "vmname"
}
variable "size" {
 default = "Standard_D2ls_v5"
}
variable "username" {
 default = "mujju"
}
variable "image" {
 default = {
 publisher = "Canonical"
 offer = "0001-com-ubuntu-server-jammy"
 sku = "22_04-lts-gen2"
 version = "latest
    }
 type = object({
 publisher = string
 offer = string
 sku = string
 version = string
 })
}
resource "azurerm_linux_virtual_machine" "example" {
 name = var.vmname
 resource_group_name = azurerm_resource_group.example.name
 location = azurerm_resource_group.example.location
 size = var.size
 admin_username = var.username
 network_interface_ids = [
 azurerm_network_interface.example.id,
 ]
 admin_ssh_key {
 username = var.username
 public_key = azurerm_ssh_public_key.example.public_key
 }
 os_disk {
 caching = "ReadWrite"
 storage_account_type = "Standard_LRS"
 }
 source_image_reference {
 publisher = var.image.publisher
 offer = var.image.offer
 sku = var.image.sku
 version = var.image.version
 }
}
