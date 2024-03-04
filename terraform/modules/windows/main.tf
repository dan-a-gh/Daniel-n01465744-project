#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_network_interface" "n01465744_windows_nic" {
  count               = var.windows_count
  name                = "${var.windows_vm.name}-nic${format("%1d", count.index + 1)}"
  location            = var.windows_rg.location
  resource_group_name = var.windows_rg.resource_group_name

  ip_configuration {
    name                          = "${var.windows_vm.name}-ipconfig${format("%1d", count.index + 1)}"
    subnet_id                     = var.windows_nic.ip_configuration.subnet_id
    private_ip_address_allocation = var.windows_nic.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.n01465744_windows_pip[count.index].id
  }
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_public_ip" "n01465744_windows_pip" {
  count               = var.windows_count
  name                = "${var.windows_vm.name}-pip${format("%1d", count.index + 1)}"
  resource_group_name = var.windows_rg.resource_group_name
  location            = var.windows_rg.location
  allocation_method   = var.windows_pip.allocation_method
  domain_name_label   = "${var.windows_vm.name}${format("%1d", count.index + 1)}"
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_windows_virtual_machine" "n01465744_windows_vm" {
  count               = var.windows_count
  name                = "${var.windows_vm.name}${format("%1d", count.index + 1)}"
  resource_group_name = var.windows_rg.resource_group_name
  location            = var.windows_rg.location
  size                = var.windows_vm.size
  admin_username      = var.windows_vm.admin_username
  admin_password      = var.windows_vm.admin_password
  computer_name       = "${var.windows_vm.name}${format("%1d", count.index + 1)}"
  network_interface_ids = [
    element(azurerm_network_interface.n01465744_windows_nic[*].id, count.index + 1),
  ]

  os_disk {
    caching              = var.windows_vm.os_disk.caching
    storage_account_type = var.windows_vm.os_disk.storage_account_type
    name                 = "${var.windows_vm.name}-ssd${format("%1d", count.index + 1)}"
  }

  source_image_reference {
    publisher = var.windows_vm.source_image_reference.publisher
    offer     = var.windows_vm.source_image_reference.offer
    sku       = var.windows_vm.source_image_reference.sku
    version   = var.windows_vm.source_image_reference.version
  }

  winrm_listener {
    protocol = var.windows_vm.winrm_listener
  }
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_virtual_machine_extension" "n01465744_windows_vm_ext_antimalware" {
  count                = var.windows_count
  name                 = "${var.windows_vm.name}-ext-av${format("%1d", count.index + 1)}"
  virtual_machine_id   = element(azurerm_windows_virtual_machine.n01465744_windows_vm[*].id, count.index + 1)
  type                 = var.windows_vm_ext_antimalware.type
  type_handler_version = var.windows_vm_ext_antimalware.type_handler_version
  publisher            = var.windows_vm_ext_antimalware.publisher
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_availability_set" "n01465744_windows_avs" {
  name                         = var.windows_avs.name
  location                     = var.windows_rg.location
  resource_group_name          = var.windows_rg.resource_group_name
  platform_fault_domain_count  = var.windows_avs.platform_fault_domain_count
  platform_update_domain_count = var.windows_avs.platform_update_domain_count
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}
