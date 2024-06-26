#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "lb_name" {
  value = azurerm_lb.n01465744_lb.name
}

output "lb_fqdn" {
  value = azurerm_public_ip.n01465744_lb_pip
}
