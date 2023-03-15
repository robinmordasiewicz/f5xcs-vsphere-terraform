data "template_file" "user_data" {
  template = file("${path.module}/cloudinit/user-data.tpl")
  vars = {
    "token"             = var.token
    "clustername"                        = var.clustername
    "hostname"                           = var.hostname
    "latitude"                            = var.latitude
    "longitude"                           = var.longitude
  }
}

data "template_file" "meta_data" {
  template = file("${path.module}/cloudinit/meta-data.tpl")
  vars = {
    "hostname" = var.hostname
  }
}

resource "libvirt_volume" "volume" {
  depends_on = [
    libvirt_cloudinit_disk.cloudinit
  ]
  name   = "${var.clustername}-${var.hostname}.qcow2"
  pool   = var.storagepool
  source = var.qcow2
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "${var.clustername}-${var.hostname}-cloud-init.iso"
  pool      = var.storagepool
  user_data = data.template_file.user_data.rendered
  meta_data = data.template_file.meta_data.rendered
}

resource "libvirt_domain" "kvm-app-stack" {
  depends_on = [
    libvirt_volume.volume
  ]
  name   = "${var.clustername}-${var.hostname}"
  memory = var.memory
  vcpu   = var.vcpu

  disk {
    volume_id = libvirt_volume.volume.id
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_name = "default"
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}
