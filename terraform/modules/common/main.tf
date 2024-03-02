#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_log_analytics_workspace" "n01465744_log_ws" {
  name                = var.log_ws.name
  location            = var.rgroup.location
  resource_group_name = var.rgroup.name
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_recovery_services_vault" "n01465744_rsv" {
  name                = var.rsv.name
  location            = var.rgroup.location
  resource_group_name = var.rgroup.name
  sku                 = var.rsv.sku
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_storage_account" "n01465744_storage_acc" {
  name                     = var.storage_acc.name
  location                 = var.rgroup.location
  resource_group_name      = var.rgroup.name
  account_tier             = var.storage_acc.account_tier
  account_replication_type = var.storage_acc.account_replication_type
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}
