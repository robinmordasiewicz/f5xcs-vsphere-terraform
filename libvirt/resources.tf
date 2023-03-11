# genisoimage -output cidata.iso -V cidata -r -J user-data meta-data

resource "libvirt_pool" "cluster" {
  name = var.clustername
  type = "dir"
  path = "/var/lib/libvirt/${var.clustername}"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  depends_on = [
    libvirt_pool.cluster
  ]
  count          = length(var.hostnames)
  name           = "${var.hostnames[count.index]}-cloudinit.iso"
  user_data      = templatefile("${path.module}/cloudinit.yml",
                                 {
                                   token       = "${var.token}",
                                   clustername = "${var.clustername}",
                                   latitude    = "${var.latitude}",
                                   longitude   = "${var.longitude}",
                                   hostname    = var.hostnames[count.index]
                                 }
                               )
  pool           = var.clustername
}

resource "libvirt_volume" "volterra" {
  depends_on = [
    libvirt_pool.cluster
  ]
  name           = "volterra-qcow2"
  pool           = var.clustername
  #source         = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030.qcow2"
  source         = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355.qcow2"
  format         = "qcow2"
}

resource "libvirt_volume" "diskimage" {
  depends_on = [
    libvirt_volume.volterra
  ]
  count          = length(var.hostnames)
  name           = "${var.hostnames[count.index]}.qcow2"
  pool           = var.clustername
  size           = 107374182400
  base_volume_id = libvirt_volume.volterra.id
  format         = "qcow2"
}

resource "libvirt_domain" "volterradomain" {
  depends_on = [
    libvirt_volume.diskimage
  ]
  count          = length(var.hostnames)
  name           = var.hostnames[count.index]
  description    = "F5 Distributed Cloud"
  memory         = "16384"
  machine        = "pc-q35-6.2"

  xml {
   # xslt         = file("${path.module}/machine.xsl")
    xslt         = templatefile("${path.module}/machine.xsl",
                                 {
                                   cloudinitiso = "/var/lib/libvirt/${var.clustername}/${var.hostnames[count.index]}-cloudinit.iso"
                                 }
                               )
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
