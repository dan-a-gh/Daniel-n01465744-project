#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "windows_private_ips" {
  value = [azurerm_network_interface.n01465744_windows_nic[*].private_ip_address]
}

output "windows_public_ips" {
  value = [azurerm_public_ip.n01465744_windows_pip[*].ip_address]
}

output "windows_fqdn" {
  value = [azurerm_public_ip.n01465744_windows_pip[*].fqdn]
}

output "windows_vm_hostnames" {
  value = [azurerm_windows_virtual_machine.n01465744_windows_vm[*].name]
}
