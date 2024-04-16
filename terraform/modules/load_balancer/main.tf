#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_public_ip" "n01465744_lb_pip" {
  name                = var.lb_pip.name
  resource_group_name = var.rgroup.name
  location            = var.rgroup.location
  allocation_method   = var.lb_pip.allocation_method
  domain_name_label   = var.lb_pip.name
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_lb" "n01465744_lb" {
  name                = var.lb.name
  location            = var.rgroup.location
  resource_group_name = var.rgroup.name

  frontend_ip_configuration {
    name                 = var.lb.frontend_ip_configuration.name
    public_ip_address_id = azurerm_public_ip.n01465744_lb_pip.id
  }
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_lb_backend_address_pool" "n01465744_lb_be_addr_pool" {
  loadbalancer_id = azurerm_lb.n01465744_lb.id
  name            = var.lb_be_addr_pool.name
}

resource "azurerm_network_interface_backend_address_pool_association" "n01465744_net_intf_be_addr_pool_assoc" {
  for_each                = var.linux_nic
  network_interface_id    = each.value
  ip_configuration_name   = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.n01465744_lb_be_addr_pool.id
  depends_on              = [var.linux_nic]
}

resource "azurerm_lb_rule" "n01465744_azurerm_lb_rule" {
  name                           = "TCP"
  loadbalancer_id                = azurerm_lb.n01465744_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb.frontend_ip_configuration.name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.n01465744_lb_be_addr_pool.id]
}
