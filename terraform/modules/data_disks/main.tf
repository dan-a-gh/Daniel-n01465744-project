#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_managed_disk" "n01465744_data_disk" {
  for_each             = var.virtual_machines
  name                 = "${each.key}-disk"
  location             = var.rgroup.location
  resource_group_name  = var.rgroup.name
  storage_account_type = var.data_disk.storage_account_type
  create_option        = var.data_disk.create_option
  disk_size_gb         = var.data_disk.disk_size_gb
  tags = {
    Assignment     = var.project_metadata.Assignment
    Name           = var.project_metadata.Name
    ExpirationDate = var.project_metadata.ExpirationDate
    Environment    = var.project_metadata.Environment
    module         = local.module
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "n01465744_vm_disk_attachment" {
  for_each           = var.virtual_machines
  managed_disk_id    = azurerm_managed_disk.n01465744_data_disk[each.key].id
  virtual_machine_id = each.value
  lun                = index(keys(var.virtual_machines), each.key)
  caching            = var.vm_disk_attachment.caching
  depends_on         = [azurerm_managed_disk.n01465744_data_disk]
}
