#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "linux_private_ips" {
  value = values(azurerm_network_interface.n01465744_linux_nic)[*].private_ip_address
}

output "linux_public_ips" {
  value = values(azurerm_public_ip.n01465744_linux_pip)[*].ip_address
}

output "linux_fqdn" {
  value = values(azurerm_public_ip.n01465744_linux_pip)[*].fqdn
}

output "linux_vm_hostnames" {
  value = values(azurerm_linux_virtual_machine.n01465744_linux_vm)[*].name
}

output "linux_vm_ids" {
  value = values(azurerm_linux_virtual_machine.n01465744_linux_vm)[*].id
}
