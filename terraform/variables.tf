#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

locals {
  vm_hostnames = flatten(concat(
    module.vmlinux_n01465744.linux_vm_hostnames,
    module.vmwindows_n01465744.windows_vm_hostnames
  ))
  vm_ids = flatten(concat(
    module.vmlinux_n01465744.linux_vm_ids,
    module.vmwindows_n01465744.windows_vm_ids
  ))
  linux_nic_ip_configuration_name = flatten([
    for nic_ip_config in module.vmlinux_n01465744.linux_nic_ip_configuration : [
      for i in nic_ip_config : [
        i.name
      ]
    ]
  ])
}

variable "project_metadata" {
  type = object({
    Assignment     = string
    Name           = string
    ExpirationDate = string
    Environment    = string
  })
  default = {
    Assignment     = "CCGC 5502 Automation Project"
    Name           = "Daniel.Allison"
    ExpirationDate = "2024-12-31"
    Environment    = "Project"
  }
}
