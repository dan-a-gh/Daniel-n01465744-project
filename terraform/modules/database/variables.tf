#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

variable "rgroup" {
  type = object({
    name     = string
    location = string
  })
}

variable "psql_server" {
  type = object({
    name                             = string
    administrator_login              = string
    administrator_login_password     = string
    sku_name                         = string
    version                          = string
    storage_mb                       = number
    backup_retention_days            = number
    geo_redundant_backup_enabled     = bool
    auto_grow_enabled                = bool
    public_network_access_enabled    = bool
    ssl_enforcement_enabled          = bool
    ssl_minimal_tls_version_enforced = string
  })
}
