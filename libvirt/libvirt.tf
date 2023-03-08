terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.19"
    }
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}
