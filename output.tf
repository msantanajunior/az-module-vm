output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}
output "nics" {
  value = azurerm_network_interface.nic[*]
}
output "vm_public_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_addresses
}
output "vm_private_ip" {
  value = azurerm_linux_virtual_machine.vm.private_ip_addresses
}