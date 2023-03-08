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
  uri = var.libvirt_server

}

data "libvirt_datacenter" "dc" {
  name = var.datacenter
}

data "libvirt_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.libvirt_datacenter.dc.id
}

data "libvirt_network" "outside" {
  name          = var.outside_network
  datacenter_id = data.libvirt_datacenter.dc.id
}

data "libvirt_network" "inside" {
  name          = var.inside_network
  datacenter_id = data.libvirt_datacenter.dc.id
}
