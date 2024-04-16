#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# COMMON MODULE
# -----------------------------------------------------------------------------

output "log_ws_name" {
  value = module.common_n01465744.log_ws_name
}

output "rsv_name" {
  value = module.common_n01465744.rsv_name
}

output "storage_acc_name" {
  value = module.common_n01465744.storage_acc_name
}

output "storage_account_uri" {
  value = module.common_n01465744.storage_account_uri
}

# DATABASE
# -----------------------------------------------------------------------------

output "db_name" {
  value = module.database_n01465744.db_name
}

# LINUX
# -----------------------------------------------------------------------------

output "linux_private_ips" {
  value = module.vmlinux_n01465744.linux_private_ips
}

output "linux_public_ips" {
  value = module.vmlinux_n01465744.linux_public_ips
}

output "linux_fqdn" {
  value = module.vmlinux_n01465744.linux_fqdn
}

output "linux_vm_hostnames" {
  value = module.vmlinux_n01465744.linux_vm_hostnames
}

output "linux_vm_ids" {
  value = module.vmlinux_n01465744.linux_vm_ids
}

output "linux_nic_id" {
  value = module.vmlinux_n01465744.linux_nic_id
}

output "linux_nic_ip_configuration" {
  value = module.vmlinux_n01465744.linux_nic_ip_configuration
}

# LOAD BALANCER
# -----------------------------------------------------------------------------

output "lb_name" {
  value = module.loadbalancer_n01465744.lb_name
}

output "lb_fqdn" {
  value = module.loadbalancer_n01465744.lb_fqdn.fqdn
}

# NETWORK
# -----------------------------------------------------------------------------

output "vnet_name" {
  value = module.network_n01465744.vnet_name
}

output "subnet_name" {
  value = module.network_n01465744.subnet_name
}

output "subnet_id" {
  value = module.network_n01465744.subnet_id
}

output "network_security_rule" {
  value = module.network_n01465744.network_security_rule
}

# RESOURCE GROUP
# -----------------------------------------------------------------------------

output "name" {
  value = module.rgroup_n01465744.name
}

output "location" {
  value = module.rgroup_n01465744.location
}

# WINDOWS
# -----------------------------------------------------------------------------

output "windows_private_ips" {
  value = module.vmwindows_n01465744.windows_private_ips
}

output "windows_public_ips" {
  value = module.vmwindows_n01465744.windows_public_ips
}

output "windows_fqdn" {
  value = module.vmwindows_n01465744.windows_fqdn
}

output "windows_vm_hostnames" {
  value = module.vmwindows_n01465744.windows_vm_hostnames
}

output "windows_vm_ids" {
  value = module.vmwindows_n01465744.windows_vm_ids
}

# DATA DISKS
# 
output "data_disks_attachment" {
  value = module.datadisk_n01465744.data_disks_attachment
}
