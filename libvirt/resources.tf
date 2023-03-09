resource "libvirt_volume" "volterra" {
  name           = "volterra-qcow2"
  pool           = "default"
  #source         = "/var/lib/libvirt/images/templates/xc-template.qcow2"
  source         = "/var/lib/libvirt/images/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030.qcow2"
  format         = "qcow2"
}

resource "libvirt_volume" "diskimage" {
  count          = length(var.hostnames)
  name           = var.hostnames[count.index]
  pool           = "default"
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

