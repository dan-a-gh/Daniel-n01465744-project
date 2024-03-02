#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

locals {
  Module = "common"
}

variable "rgroup" {
  type = object({
    name     = string
    location = string
  })
}

variable "log_ws" {
  type = object({
    name = string
  })
}

variable "rsv" {
  type = object({
    name = string
    sku  = string
  })
}

variable "storage_acc" {
  type = object({
    name                     = string
    location                 = string
    resource_group_name      = string
    account_tier             = string
    account_replication_type = string
  })
}

variable "project_metadata" {
  type = object({
    Assignment     = string
    Name           = string
    ExpirationDate = string
    Environment    = string
  })
}
