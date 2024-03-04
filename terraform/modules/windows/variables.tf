#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

locals {
  Module = "windows"
}

variable "windows_rg" {
  type = object({
    resource_group_name = string
    location            = string
  })
}

variable "windows_count" {
  type = number
}

variable "windows_vm" {
  type = object({
    name           = string
    admin_username = string
    admin_password = string
    size           = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    winrm_listener = string
    boot_diagnostics = object({
      storage_account_uri = string
    })
  })
}

variable "windows_vm_ext_antimalware" {
  type = object({
    type                 = string
    type_handler_version = string
    publisher            = string
  })
}

variable "windows_avs" {
  type = object({
    name                         = string
    platform_fault_domain_count  = number
    platform_update_domain_count = number
  })
}

variable "windows_nic" {
  type = object({
    ip_configuration = object({
      subnet_id                     = string
      private_ip_address_allocation = string
    })
  })
}

variable "windows_pip" {
  type = object({
    allocation_method = string
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
