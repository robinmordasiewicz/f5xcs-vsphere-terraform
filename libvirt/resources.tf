# genisoimage -output cidata.iso -V cidata -r -J user-data meta-data

data "template_file" "user_data" {
  template = file("${path.module}/cloudinit.yaml")
}

resource "libvirt_pool" "cluster" {
  name = "xccluster"
  type = "dir"
  path = "/var/lib/libvirt/xcimages"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = "xc-cloudinit.iso"
  user_data      = templatefile("${path.module}/cloudinit.yml", {})
  pool           = "xccluster"
}

resource "libvirt_volume" "volterra" {
  name           = "volterra-qcow2"
  pool           = "xccluster"
  source         = "/tmp/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030.qcow2"
  format         = "qcow2"
}

resource "libvirt_volume" "diskimage" {
  count          = length(var.hostnames)
  name           = var.hostnames[count.index]
  pool           = "xccluster"
  size           = 107374182400
  base_volume_id = libvirt_volume.volterra.id
  format         = "qcow2"
}

resource "libvirt_domain" "volterradomain" {
  count          = length(var.hostnames)
  name           = var.hostnames[count.index]
  description    = "F5 Distributed Cloud"
  memory         = "16384"
  machine        = "pc-q35-6.2"

  xml {
    xslt         = file("${path.module}/machine.xsl")
  }
  vcpu           = 4
  qemu_agent     = true

  network_interface {
    macvtap      = "enp109s0"
  }
 
  cpu {
    mode         = "host-passthrough"
  }

  console {
    type         = "pty"
    target_port  = "0"
    target_type  = "serial"
  }

  console {
    type         = "pty"
    target_type  = "virtio"
    target_port  = "1"
  }

  disk {
    volume_id    = element(libvirt_volume.diskimage[*].id, count.index)
  }

  graphics {
    type         = "spice"
    listen_type  = "address"
    autoport     = "true"
  }
}
