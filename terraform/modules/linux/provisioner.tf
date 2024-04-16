#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# provisioner.tf                                                              #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "null_resource" "n01465744_linux_provisioner" {
  depends_on = [
    var.data_disk_attach
  ]
  provisioner "local-exec" {
    command     = "ansible-playbook ./playbook.yml"
    working_dir = "../ansible"
  }
}
