#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#


resource "azurerm_availability_set" "n01465744_linux_avs" {
  name                         = var.linux_avs.name
  location                     = var.linux_rg.location
  resource_group_name          = var.linux_rg.name
  platform_fault_domain_count  = var.linux_avs.platform_fault_domain_count
  platform_update_domain_count = var.linux_avs.platform_update_domain_count
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_linux_virtual_machine" "n01465744_linux_vm" {
  count               = var.linux_count
  name                = "${var.linux_vm.name}${format("%1d", count.index + 1)}"
  resource_group_name = var.linux_rg.name
  location            = var.linux_rg.location
  size                = var.linux_vm.size
  admin_username      = var.linux_vm.admin_username
  computer_name       = "${var.linux_vm.name}${format("%1d", count.index + 1)}"
  network_interface_ids = [
    element(azurerm_network_interface.n01465744_linux_nic[*].id, count.index + 1),
  ]

  admin_ssh_key {
    username   = var.linux_vm.admin_username
    public_key = file(var.public_key)
  }

  os_disk {
    caching              = var.linux_vm.os_disk.caching
    storage_account_type = var.linux_vm.os_disk.storage_account_type
    name                 = "${var.linux_vm.name}-ssd${format("%1d", count.index + 1)}"
  }

  source_image_reference {
    publisher = var.linux_vm.source_image_reference.publisher
    offer     = var.linux_vm.source_image_reference.offer
    sku       = var.linux_vm.source_image_reference.sku
    version   = var.linux_vm.source_image_reference.version
  }

  boot_diagnostics {
    storage_account_uri = var.linux_vm.boot_diagnostics.storage_account_uri
  }

  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_virtual_machine_extension" "n01465744_linux_vm_ext_net_watch" {
  count                = var.linux_count
  name                 = "${var.linux_vm.name}-ext-net-watch${format("%1d", count.index + 1)}"
  virtual_machine_id   = element(azurerm_linux_virtual_machine.n01465744_linux_vm[*].id, count.index + 1)
  type                 = var.linux_vm_ext_net_watch.type
  type_handler_version = var.linux_vm_ext_net_watch.type_handler_version
  publisher            = var.linux_vm_ext_net_watch.publisher
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_virtual_machine_extension" "n01465744_linux_vm_ext_monitor" {
  count                = var.linux_count
  name                 = "${var.linux_vm.name}-ext-monitor${format("%1d", count.index + 1)}"
  virtual_machine_id   = element(azurerm_linux_virtual_machine.n01465744_linux_vm[*].id, count.index + 1)
  type                 = var.linux_vm_ext_monitor.type
  type_handler_version = var.linux_vm_ext_monitor.type_handler_version
  publisher            = var.linux_vm_ext_monitor.publisher
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_network_interface" "n01465744_linux_nic" {
  count               = var.linux_count
  name                = "${var.linux_vm.name}-nic${format("%1d", count.index + 1)}"
  location            = var.linux_rg.location
  resource_group_name = var.linux_rg.name

  ip_configuration {
    name                          = "${var.linux_vm.name}-ipconfig${format("%1d", count.index + 1)}"
    subnet_id                     = var.linux_nic.ip_configuration.subnet_id
    private_ip_address_allocation = var.linux_nic.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.n01465744_linux_pip[count.index].id
  }
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}

resource "azurerm_public_ip" "n01465744_linux_pip" {
  count               = var.linux_count
  name                = "${var.linux_vm.name}-pip${format("%1d", count.index + 1)}"
  resource_group_name = var.linux_rg.name
  location            = var.linux_rg.location
  allocation_method   = var.linux_pip.allocation_method
  domain_name_label   = "${var.linux_vm.name}${format("%1d", count.index + 1)}"
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.Module
  }
}
