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
  password               = var.password
  libvirt_server         = var.libvirt_server
  datacenter             = var.datacenter
  libvirt_host_one       = var.libvirt_host_one
  libvirt_host_two       = var.libvirt_host_two
  libvirt_host_three     = var.libvirt_host_three
  datastore_one          = var.datastore_one
  datastore_two          = var.datastore_two
  datastore_three        = var.datastore_three
  resource_pool          = var.resource_pool
  nodenames              = var.nodenames
  outside_network        = var.outside_network
  inside_network         = var.inside_network
  dnsservers             = var.dnsservers
  guest_type             = var.guest_type
  cpus                   = var.cpus
  memory                 = var.memory
  certifiedhardware      = var.certifiedhardware
  publicinterfaceaddress = var.public_addresses
  publicdefaultroute     = var.publicdefaultroute
  publicdefaultgateway   = var.publicdefaultgateway
  sitelatitude           = var.sitelatitude
  sitelongitude          = var.sitelongitude
  clustername            = format("%s-cluster", var.sitename)
  sitetoken              = var.sitetoken
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
