#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_postgresql_server" "n01465744_psql_server" {
  name                = var.psql_server.name
  location            = var.rgroup.location
  resource_group_name = var.rgroup.name

  administrator_login          = var.psql_server.administrator_login
  administrator_login_password = var.psql_server.administrator_login_password

  sku_name                         = var.psql_server.sku_name
  version                          = var.psql_server.version
  storage_mb                       = var.psql_server.storage_mb
  backup_retention_days            = var.psql_server.backup_retention_days
  geo_redundant_backup_enabled     = var.psql_server.geo_redundant_backup_enabled
  auto_grow_enabled                = var.psql_server.auto_grow_enabled
  public_network_access_enabled    = var.psql_server.public_network_access_enabled
  ssl_enforcement_enabled          = var.psql_server.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.psql_server.ssl_minimal_tls_version_enforced
}
