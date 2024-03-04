#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# data.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

data "azurerm_key_vault" "n01465744_kv" {
  name                = "n01465744-kv"
  resource_group_name = "n01465744_key_vault_RG"
}

data "azurerm_key_vault_secret" "windows_admin_password" {
  name         = "WindowsAdminPassword"
  key_vault_id = data.azurerm_key_vault.n01465744_kv.id
}
