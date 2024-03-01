#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_virtual_network" "n01465744_vnet" {
  name                = var.vnet.name
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name
  address_space       = var.vnet.address_space
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_subnet" "n01465744_subnet" {
  name                 = var.subnet.name
  resource_group_name  = var.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.n01465744_vnet.name
  address_prefixes     = var.subnet.address_space
}

resource "azurerm_network_security_group" "n01465744_nsg" {
  name                = var.nsg.name
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_network_security_rule" "n01465744_nsr" {
  for_each = {
    for index, nsr in var.nsg.sec_rule :
    nsr.name => nsr
  }
  resource_group_name         = var.vnet.resource_group_name
  network_security_group_name = var.nsg.name
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  depends_on                  = [azurerm_network_security_group.n01465744_nsg]
}

resource "azurerm_subnet_network_security_group_association" "n01465744_snsga1" {
  subnet_id                 = azurerm_subnet.n01465744_subnet.id
  network_security_group_id = azurerm_network_security_group.n01465744_nsg.id
}
