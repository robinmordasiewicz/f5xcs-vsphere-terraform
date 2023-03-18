# main.tf

module "util" {
  source             = "./util"
}

module "libvirt" {
  source             = "./libvirt"
  #libvirt_depends_on = module.volterraedge.volterra_token.token
  #token              = module.volterraedge.volterra_token.token.id
  libvirt_depends_on = module.volterraedge.token
  token              = module.volterraedge.token
  hostnames          = var.hostnames
  libvirt_admin      = var.libvirt_admin
  libvirt_ip         = var.libvirt_ip
  latitude           = var.latitude
  longitude          = var.longitude
  clustername        = var.clustername
  qcow2              = var.qcow2
}

module "volterraedge" {
  source             = "./volterraedge"
  VES_P12_PASSWORD   = var.VES_P12_PASSWORD
  VOLT_API_P12_FILE  = var.VOLT_API_P12_FILE
  tenant             = var.tenant
  clustername        = var.clustername
  k8scluster         = var.k8scluster
  hostnames          = var.hostnames
  latitude           = var.latitude
  longitude          = var.longitude
  token              = var.token
  address            = var.address
}
