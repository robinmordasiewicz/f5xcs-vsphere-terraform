# main.tf

# Util Module
# - Random Prefix Generation
# - Random Password Generation
module "util" {
  source = "./util"
}

# Vsphere Module
# Import OVA and build machine(s)
module "libvirt" {
  source = "./libvirt"

  xcovapath              = var.xcovapath
  user                   = var.user
  libvirt_uri            = var.libvirt_uri
  hostnames              = var.hostnames
  nodenames              = var.nodenames
  guest_type             = var.guest_type
  cpus                   = var.cpus
  memory                 = var.memory
  cluster_size           = var.cluster_size
}

# Volterra Module
# Build Site Token and Cloud Credential
# Build out libvirt site
module "xc" {
  source = "./xc"

  depends_on = [
    module.libvirt.vm1, module.libvirt.vm2, module.libvirt.vm3
  ]

  sitename         = var.sitename
  namespace        = var.namespace
  projectName      = var.projectName
  url              = var.api_url
  api_p12_file     = var.api_p12_file
  projectPrefix    = module.util.env_prefix
  sshPublicKeyPath = var.sshPublicKeyPath
  sshPublicKey     = var.sshPublicKey
  tenant           = var.tenant
  nodenames        = var.nodenames
  sitelatitude     = var.sitelatitude
  sitelongitude    = var.sitelongitude
  cluster_size     = var.cluster_size
}
