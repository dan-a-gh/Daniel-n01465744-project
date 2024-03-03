#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "vnet_name" {
  value = azurerm_virtual_network.n01465744_vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.n01465744_subnet.name
}

output "subnet_id" {
  value = azurerm_subnet.n01465744_subnet.id
}
