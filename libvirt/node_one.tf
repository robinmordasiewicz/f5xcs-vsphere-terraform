
data "libvirt_datastore" "datastore_one" {
  name          = var.datastore_one
  datacenter_id = data.libvirt_datacenter.dc.id
}

data "libvirt_host" "host_one" {
  name          = var.libvirt_host_one
  datacenter_id = data.libvirt_datacenter.dc.id
}

resource "libvirt_domain" "vm" {
  count            = var.cluster_size >= 1 ? 1 : 0
  name             = var.nodenames["nodeone"]
  datacenter_id    = data.libvirt_datacenter.dc.id
  resource_pool_id = data.libvirt_pool.pool.id
  datastore_id     = data.libvirt_datastore.datastore_one.id
  host_system_id   = data.libvirt_host.host_one.id

  num_cpus = var.cpus
  memory   = var.memory
  guest_id = var.guest_type

  network_interface {
    network_id   = data.libvirt_network.outside.id
    adapter_type = "vmxnet3"
  }
  network_interface {
    network_id   = data.libvirt_network.inside.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 120
    eagerly_scrub    = false
    thin_provisioned = false
  }

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = var.xcovapath

    disk_provisioning = "thick"

    ovf_network_map = {
      "OUTSIDE" = data.libvirt_network.outside.id
      "REGULAR" = data.libvirt_network.inside.id
    }
  }

  vapp {
    properties = {
      "guestinfo.ves.certifiedhardware"           = var.certifiedhardware,
      "guestinfo.interface.0.ip.0.address"        = var.publicinterfaceaddress["nodeone"],
      "guestinfo.interface.0.name"                = "eth0",
      "guestinfo.interface.0.route.0.destination" = var.publicdefaultroute,
      "guestinfo.interface.0.dhcp"                = "no",
      "guestinfo.interface.0.role"                = "public",
      "guestinfo.interface.0.route.0.gateway"     = var.publicdefaultgateway,
      "guestinfo.dns.server.0"                    = var.dnsservers["primary"],
      "guestinfo.dns.server.1"                    = var.dnsservers["secondary"],
      "guestinfo.ves.regurl"                      = "ves.volterra.io",
      "guestinfo.hostname"                        = var.nodenames["nodeone"],
      "guestinfo.ves.clustername"                 = var.clustername,
      "guestinfo.ves.latitude"                    = var.sitelatitude,
      "guestinfo.ves.longitude"                   = var.sitelongitude,
      "guestinfo.ves.token"                       = var.sitetoken
    }
  }

}

output "vm1" {
  value = libvirt_domain.vm[*].id
}
