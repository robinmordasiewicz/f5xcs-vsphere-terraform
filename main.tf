# main.tf

#module "util" {
#  source = "./util"
#}

module "libvirt" {
  source = "./libvirt"
  token              = module.volterraedge.token
  appstacksite       = module.volterraedge.appstacksite
  hostnames          = local.hostnames
  libvirt_admin      = var.libvirt_admin
  libvirt_ip         = var.libvirt_ip
  latitude           = var.latitude
  longitude          = var.longitude
  clustername        = var.clustername
  qcow2              = var.qcow2
}

module "volterraedge" {
  source            = "./volterraedge"
  VOLT_API_P12_FILE = var.VOLT_API_P12_FILE
  VES_P12_PASSWORD  = var.VES_P12_PASSWORD
  url               = local.url
  clustername       = var.clustername
  k8scluster        = var.k8scluster
  masternodes       = var.masternodes
  workernodes       = var.workernodes
  latitude          = var.latitude
  longitude         = var.longitude
  token             = var.token
  address           = var.address
  kvmappstack       = module.libvirt.kvmappstack
}
