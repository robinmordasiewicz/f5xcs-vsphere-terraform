# main.tf

module "util" {
  source            = "./util"
}

module "libvirt" {
  source            = "./libvirt"
  xcovapath         = var.xcovapath
  libvirt_uri       = var.libvirt_uri
  hostnames         = var.hostnames
  nodenames         = var.nodenames
  guest_type        = var.guest_type
  cpus              = var.cpus
  memory            = var.memory
  cluster_size      = var.cluster_size
  libvirt_admin     = var.libvirt_admin
  libvirt_ip        = var.libvirt_ip
}

module "xc" {
  source = "./xc"

  depends_on = [
    module.libvirt.vm1,
    module.libvirt.vm2,
    module.libvirt.vm3
  ]

  sitename          = var.sitename
  namespace         = var.namespace
  projectName       = var.projectName
  url               = var.api_url
  VOLT_API_P12_FILE = var.VOLT_API_P12_FILE
  projectPrefix     = module.util.env_prefix
  sshPublicKeyPath  = var.sshPublicKeyPath
  sshPublicKey      = var.sshPublicKey
  tenant            = var.tenant
  nodenames         = var.nodenames
  sitelatitude      = var.sitelatitude
  sitelongitude     = var.sitelongitude
  cluster_size      = var.cluster_size
}
