#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "log_ws_name" {
  value = azurerm_log_analytics_workspace.n01465744_log_ws.name
}

output "rsv_name" {
  value = azurerm_recovery_services_vault.n01465744_rsv.name
}

output "storage_acc_name" {
  value = azurerm_storage_account.n01465744_storage_acc.name
}

output "storage_account_uri" {
  value = azurerm_storage_account.n01465744_storage_acc.primary_blob_endpoint
}
