#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

module "rgroup_n01465744" {
  source = "./modules/resource_group"
  n01465744_RG = {
    name     = "rgroup_n01465744"
    location = "CanadaCentral"
  }
  project_metadata = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Daniel.Allison"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
