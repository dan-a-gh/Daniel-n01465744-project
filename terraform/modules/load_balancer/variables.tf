#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

locals {
  Module = "load_balancer"
}

variable "rgroup" {
  type = object({
    name     = string
    location = string
  })
}

variable "lb" {
  type = object({
    name = string
    frontend_ip_configuration = object({
      name = string
    })
  })
}

variable "lb_pip" {
  type = object({
    name              = string
    allocation_method = string
  })
}

variable "lb_nat_rule" {
  type = list(object({
    name                           = string
    protocol                       = string
    frontend_port                  = number
    backend_port                   = number
    frontend_ip_configuration_name = string
  }))
}

variable "lb_be_addr_pool" {
  type = object({
    name = string
  })
}

variable "linux_nic" {
  type = map(string)
}

variable "project_metadata" {
  type = object({
    Assignment     = string
    Name           = string
    ExpirationDate = string
    Environment    = string
  })
}
