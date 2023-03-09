terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source     = "dmacvicar/libvirt"
      version    = "0.7.1"
    }
  }
}

provider "libvirt" {
  uri     = "qemu+ssh://${var.libvirt_admin}@${var.libvirt_ip}/system?sshauth=privkey&no_verify=1"
}
