#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

variable "project_metadata" {
  type = object({
    Assignment     = string
    Name           = string
    ExpirationDate = string
    Environment    = string
  })
  default = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Daniel.Allison"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
