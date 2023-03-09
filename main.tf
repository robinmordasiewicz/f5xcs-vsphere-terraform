# main.tf

module "util" {
  source            = "./util"
}

module "libvirt" {
  source            = "./libvirt"
  hostnames         = var.hostnames
  libvirt_admin     = var.libvirt_admin
  libvirt_ip        = var.libvirt_ip
}

module "volterraedge" {
  source = "./volterraedge"
#  depends_on = [
#    module.libvirt.vm1,
#    module.libvirt.vm2,
#    module.libvirt.vm3
#  ]
  VES_P12_PASSWORD  = var.VES_P12_PASSWORD
  VOLT_API_KEY      = var.VOLT_API_KEY
  VOLT_API_CERT     = var.VOLT_API_CERT
  VOLT_API_P12_FILE = var.VOLT_API_P12_FILE
  sitename          = var.sitename
  namespace         = var.namespace
  projectName       = var.projectName
  projectPrefix     = module.util.env_prefix
  tenant            = var.tenant
  hostnames         = var.hostnames
  sitelatitude      = var.sitelatitude
  sitelongitude     = var.sitelongitude
}
