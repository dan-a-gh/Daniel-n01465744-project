#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

locals {
  module = "data_disks"
}

variable "rgroup" {
  type = object({
    name     = string
    location = string
  })
}

variable "virtual_machines" {
  type = map(string)
}

variable "data_disk" {
  type = object({
    storage_account_type = string
    create_option        = string
    disk_size_gb         = number
  })
}

variable "vm_disk_attachment" {
  type = object({
    caching = string
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
