provider "libvirt" {
  uri = "qemu+ssh://${var.libvirt_admin}@${var.libvirt_ip}/system?sshauth=privkey&no_verify=1"
}
