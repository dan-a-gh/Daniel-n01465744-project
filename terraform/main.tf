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

module "vmlinux_n01465744" {
  source = "./modules/linux"
  linux_rg = {
    name     = module.rgroup_n01465744.name
    location = module.rgroup_n01465744.location
  }
  linux_avs = {
    name                         = "n01465744_linux_avs"
    platform_fault_domain_count  = 2
    platform_update_domain_count = 5
  }
  linux_nic = {
    ip_configuration = {
      subnet_id                     = module.network_n01465744.subnet_id
      private_ip_address_allocation = "Dynamic"
    }
  }
  linux_vm = {
    name                = toset(["n01465744-u-vm1", "n01465744-u-vm2", "n01465744-u-vm3"])
    resource_group_name = module.rgroup_n01465744.name
    location            = module.rgroup_n01465744.location
    size                = "Standard_B1s"
    admin_username      = "n01465744"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
    }
    source_image_reference = {
      publisher = "OpenLogic"
      offer     = "CentOs"
      sku       = "8_2-gen2"
      version   = "8.2.2020111801"
    }
    boot_diagnostics = {
      storage_account_uri = module.common_n01465744.storage_account_uri
      depends_on          = [module.common_n01465744.storage_account_uri]
    }
  }
  linux_vm_ext_net_watch = {
    type                 = "NetworkWatcherAgentLinux"
    type_handler_version = "1.4"
    publisher            = "Microsoft.Azure.NetworkWatcher"
  }
  linux_vm_ext_monitor = {
    type                 = "AzureMonitorLinuxAgent"
    type_handler_version = "1.9"
    publisher            = "Microsoft.Azure.Monitor"
  }
  linux_pip = {
    allocation_method = "Dynamic"
  }
  public_key  = "/var/home/danielallison/.ssh/id_rsa.pub"
  private_key = "/var/home/danielallison/.ssh/id_rsa"
  linux_provisioner = {
    remote_exec = {
      connection = {
        type = "ssh"
      }
    }
  }
  project_metadata = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
  }
}

module "vmwindows_n01465744" {
  source = "./modules/windows"
  windows_rg = {
    resource_group_name = module.rgroup_n01465744.name
    location            = module.rgroup_n01465744.location
  }
  windows_count = 1
  windows_vm = {
    name           = "n01465744-w-vm"
    size           = "Standard_B1s"
    admin_username = "n01465744"
    admin_password = data.azurerm_key_vault_secret.windows_admin_password.value
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
    }
    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
    winrm_listener = "Http"
    boot_diagnostics = {
      storage_account_uri = module.common_n01465744.storage_account_uri
      depends_on          = [module.common_n01465744.storage_account_uri]
    }
  }
  windows_vm_ext_antimalware = {
    type                 = "IaaSAntimalware"
    type_handler_version = "1.7"
    publisher            = "Microsoft.Azure.Security"
  }
  windows_avs = {
    name                         = "windows_avs"
    platform_fault_domain_count  = 2
    platform_update_domain_count = 5
  }
  windows_nic = {
    ip_configuration = {
      subnet_id                     = module.network_n01465744.subnet_id
      private_ip_address_allocation = "Dynamic"
    }
  }
  windows_pip = {
    allocation_method = "Dynamic"
  }
  project_metadata = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
  }
}

module "datadisk_n01465744" {
  source = "./modules/data_disks"
  rgroup = {
    name     = module.rgroup_n01465744.name
    location = module.rgroup_n01465744.location
  }
  virtual_machines = zipmap(
    local.vm_hostnames,
    local.vm_ids
  )
  data_disk = {
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = 10
  }
  vm_disk_attachment = {
    caching = "ReadWrite"
  }
  project_metadata = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
  }
}
