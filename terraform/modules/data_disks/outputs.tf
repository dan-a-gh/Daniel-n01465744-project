#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "data_disks_attachment" {
  value = values(azurerm_virtual_machine_data_disk_attachment.n01465744_vm_disk_attachment)[*]
}
