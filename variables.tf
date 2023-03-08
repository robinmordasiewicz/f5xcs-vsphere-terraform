variable "cluster_size" {
  type        = number
  description = "REQUIRED:  Set Cluster Size, options are 1 or 3 today."
  default     = 3
}
variable "user" {
  type        = string
  description = "REQUIRED:  Provide a vpshere username.  [admin@libvirt.local]"
  default     = "admin@libvirt.local"
}
variable "password" {
  type        = string
  description = "REQUIRED:  Provide a libvirt password."
  default     = "pass@word1"
}
variable "libvirt_server" {
  type        = string
  description = "REQUIRED:  Provide a libvirt server or appliance. [vSphere URL (IP, hostname or FQDN)]"
  default     = "libvirt.domain.com"
}
variable "libvirt_uri" {
  type        = string
  description = "REQUIRED: credentials for KVM"
  default     = "qemu+ssh://robin@192.168.1.95/system?sshauth=privkey&no_verify=1"
}
variable "datacenter" {
  type        = string
  description = "REQUIRED:  Provide a Datacenter Name."
  default     = "Default Datacenter"
}
variable "libvirt_host_one" {
  type        = string
  description = "REQUIRED:  Provide a vcenter host. [vCenter URL (IP, hostname or FQDN)]"
  default     = "vcenter.domain.com"
}
variable "libvirt_host_two" {
  type        = string
  description = "REQUIRED:  Provide a vcenter host. [vCenter URL (IP, hostname or FQDN)]"
  default     = "vcenter2.domain.com"
}
variable "libvirt_host_three" {
  type        = string
  description = "REQUIRED:  Provide a vcenter host. [vCenter URL (IP, hostname or FQDN)]"
  default     = "vcenter3.domain.com"
}
variable "datastore_one" {
  type        = string
  description = "REQUIRED:  Provide a Datastore Name."
  default     = "datastore-1"
}
variable "datastore_two" {
  type        = string
  description = "REQUIRED:  Provide a Datastore Name."
  default     = "datastore-2"
}
variable "datastore_three" {
  type        = string
  description = "REQUIRED:  Provide a Datastore Name."
  default     = "datastore-3"
}
variable "resource_pool" {
  type        = string
  description = "REQUIRED:  Provide a Resource Pool Name."
  default     = "resource pool"

}
# Virtual Machine configuration

# Outside Network
variable "outside_network" {
  type        = string
  description = "REQUIRED:  Provide a Name for the Outside Interface Network. [ SLO ]"
  default     = "SLO"
}
variable "inside_network" {
  type        = string
  description = "REQUIRED:  Provide a Name for the Inside Interface Network. [ SLI ]"
  default     = "SLI"
}
# VM Number of CPU's
variable "cpus" {
  type        = number
  description = "REQUIRED:  Provide a vCPU count.  [ Not Less than 4, and do not limit each instance less than 2.9GHz ]"
  default     = 4
}
# VM Memory in MB
variable "memory" {
  type        = number
  description = "REQUIRED:  Provide RAM in Mb.  [ Not Less than 14336Mb ]"
  default     = 16384
}
#OVA Path
variable "xcovapath" {
  type        = string
  description = "REQUIRED: Path to XC OVA. See https://docs.cloud.f5.com/docs/images/node-vmware-images"
  default     = "/home/michael/Downloads/centos-7.2009.10-202107041731.ova"
}
#Guest Type
variable "guest_type" {
  type        = string
  description = "Guest OS Type: centos7_64Guest, other3xLinux64Guest"
  default     = "other3xLinux64Guest"
}

## XC Values
// Required Variable
variable "projectName" {
  type        = string
  description = "REQUIRED:  Provide a Prefix for use in F5 XC created resources"
  default     = "project-name"
}
variable "tenant" {
  type        = string
  description = "REQUIRED:  Provide the F5 XC Tenant name."
  default     = "xc tenant id"
}

variable "certifiedhardware" {
  type        = string
  description = "REQUIRED: XC Certified Hardware Type: kvm-voltmesh, kvm-voltstack-combo, kvm-regular-nic-voltmesh, kvm-multi-nic-voltmesh, kvm-multi-nic-voltstack-combo"
  default     = "kvm-voltstack-combo"
}

variable "public_addresses" {
  type        = map(string)
  description = "REQUIRED: XC Node Public Interfaces Addresses"
  default = {
    nodeone   = "10.1.1.66/24"
    nodetwo   = "10.1.1.67/24"
    nodethree = "10.1.1.68/24"
  }
}

variable "publicinterfaceaddress" {
  type        = string
  description = "REQUIRED: XC Public interface Address.  Must include CIDR notation."
  default     = "10.1.1.66/24"
}

variable "publicdefaultroute" {
  type        = string
  description = "REQUIRED: XC Public default route.  Must include CIDR notation."
  default     = "0.0.0.0/0"
}

variable "publicdefaultgateway" {
  type        = string
  description = "REQUIRED: XC Public default route.  Must include CIDR notation."
  default     = "10.1.1.1"
}

variable "sitelatitude" {
  type        = string
  description = "REQUIRED: Site Physical Location Latitude. See https://www.latlong.net/"
  default     = "30"
}
variable "sitelongitude" {
  type        = string
  description = "REQUIRED: Site Physical Location Longitude. See https://www.latlong.net/"
  default     = "-75"
}

variable "dnsservers" {
  description = "REQUIRED: XC Site DNS Servers."
  type        = map(string)
  default = {
    primary   = "8.8.8.8"
    secondary = "8.8.4.4"
  }
}
variable "nodenames" {
  description = "REQUIRED: XC Node Names."
  type        = map(string)
  default = {
    nodeone   = "edgesite-0"
    nodetwo   = "edgesite-1"
    nodethree = "edgesite-2"
  }
}

variable "clustername" {
  type        = string
  description = "REQUIRED: Site Cluster Name."
  default     = "coleman-libvirt-cluster"
}

variable "sitetoken" {
  type        = string
  description = "REQUIRED: Site Registration Token."
  default     = "12345678910"
}

variable "sitename" {
  type        = string
  description = "REQUIRED:  This is name for your deployment"
  default     = "adrastea"
}

variable "sshPublicKey" {
  type        = string
  description = "OPTIONAL: ssh public key for instances"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCXDDEkuD25u74rkkBBgJP9FqiPM1d2a+PCTusqY/5FBE4mnDTDhaXfvWWN/atGtpnOu7MppEcQVuZGAcl4k0+JSP69WHVYPBC1354ra7cYsuhHYy8lbD2Kk9LcLDGBUKmzGiab080GZ1dQEwReVYrw+6YiI6aU6IDLx2gHmVNxsw=="
}

variable "sshPublicKeyPath" {
  type        = string
  description = "OPTIONAL: ssh public key path for instances"
  default     = "~/.ssh/id_rsa.pub"
}

// Required Variable
variable "api_p12_file" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api-creds.p12"
}

variable "namespace" {
  type        = string
  description = "REQUIRED:  This is your volterra App Namespace"
  default     = "namespace"
}

variable "api_cert" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api2.cer"
}

variable "api_key" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api.key"
}

variable "api_url" {
  type        = string
  description = "REQUIRED:  This is your volterra API url"
  default     = "https://acme-corp.console.ves.volterra.io/api"
}
