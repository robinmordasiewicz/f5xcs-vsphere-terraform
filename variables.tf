variable "cluster_size" {
  type        = number
  description = "REQUIRED:  Set Cluster Size, options are 1 or 3 today."
  default     = 3
}

variable "hostnames" {
  description    = "Create these hosts"
  type           = list(string)
  default        = ["mains01", "mains02", "mains03"]
}

variable "libvirt_admin" {
  type        = string
}

variable "libvirt_ip" {
  type        = string
}

variable "VOLT_API_P12_FILE" {
  type        = string
}

variable "VES_P12_PASSWORD" {
  type        = string
}

variable "tenant" {
  type        = string
}

variable "datacenter" {
  type        = string
  description = "REQUIRED:  Provide a Datacenter Name."
  default     = "Default Datacenter"
}

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

variable "cpus" {
  type        = number
  description = "REQUIRED:  Provide a vCPU count.  [ Not Less than 4, and do not limit each instance less than 2.9GHz ]"
  default     = 4
}

variable "memory" {
  type        = number
  description = "REQUIRED:  Provide RAM in Mb.  [ Not Less than 14336Mb ]"
  default     = 16384
}

variable "xcovapath" {
  type        = string
  default     = "/home/michael/Downloads/centos-7.2009.10-202107041731.ova"
}

variable "guest_type" {
  type        = string
  default     = "other3xLinux64Guest"
}

variable "projectName" {
  type        = string
  default     = "project-name"
}

variable "certifiedhardware" {
  type        = string
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

variable "namespace" {
  type        = string
  description = "REQUIRED:  This is your volterra App Namespace"
  default     = "namespace"
}

variable "VOLT_API_CERT" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api2.cer"
}

variable "VOLT_API_KEY" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api.key"
}

variable "VOLT_API_URL" {
  type        = string
  description = "REQUIRED:  This is your volterra API url"
  default     = "https://acme-corp.console.ves.volterra.io/api"
}
