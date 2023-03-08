provider "libvirt" {
  user           = var.user
  password       = var.password
  libvirt_server = var.libvirt_server

  allow_unverified_ssl = true
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
