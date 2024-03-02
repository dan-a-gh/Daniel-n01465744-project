#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

module "rgroup_n01465744" {
  source = "./modules/resource_group"
  n01465744_RG = {
    name     = "n01465744_RG"
    location = "CanadaCentral"
  }
  project_metadata = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
  }
}

module "network_n01465744" {
  source = "./modules/network"
  vnet = {
    name                = "n01465744_vnet"
    location            = module.rgroup_n01465744.location
    resource_group_name = module.rgroup_n01465744.name
    address_space       = ["10.0.0.0/16"]
  }
  subnet = {
    name          = "n01465744_subnet"
    address_space = ["10.0.0.0/24"]
  }
  nsg = {
    name = "nsg1"
    sec_rule = [
      {
        name                       = "rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "rule2"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "rule3"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5985"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "rule4"
        priority                   = 400
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
  project_metadata = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
  }
}

module "common_n01465744" {
  source = "./modules/common"
  rgroup = {
    name     = module.rgroup_n01465744.name
    location = module.rgroup_n01465744.location
  }
  log_ws = {
    name = "n01465744-log-ws"
  }
  rsv = {
    name = "n01465744-rsv"
    sku  = "Standard"
  }
  storage_acc = {
    name                     = "n01465744storageacc"
    location                 = module.rgroup_n01465744.location
    resource_group_name      = module.rgroup_n01465744.name
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
  project_metadata = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
  }
}
