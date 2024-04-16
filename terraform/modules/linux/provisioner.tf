#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# provisioner.tf                                                              #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "null_resource" "n01465744_linux_provisioner" {
  for_each = var.linux_vm.name
  depends_on = [
    azurerm_linux_virtual_machine.n01465744_linux_vm
  ]
  provisioner "remote-exec" {
    connection {
      type        = var.linux_provisioner.remote_exec.connection.type
      user        = var.linux_vm.admin_username
      private_key = file(var.private_key)
      host        = azurerm_linux_virtual_machine.n01465744_linux_vm[each.key].public_ip_address
    }
    inline = [
      "python3 -m pip install --user pipx",
      "python3 -m pipx ensurepath",
      "sudo pipx ensurepath --global",
      "pipx install --include-deps ansible",
      "ansible-playbook ../ansible/playbook.yml"
    ]
  }
}
