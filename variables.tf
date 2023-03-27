variable "VOLT_API_P12_FILE" {
  type = string
  sensitive = true
}

variable "VES_P12_PASSWORD" {
  type = string
  sensitive = true
}

variable "tenant" {
  type = string
  sensitive = true
}

locals {
  hostnames         = concat(var.masternodes, var.workernodes)
  url               = "https://${var.tenant}.console.ves.volterra.io/api"
  VOLT_API_P12_FILE = var.VOLT_API_P12_FILE
  VES_P12_PASSWORD  = var.VES_P12_PASSWORD
  tenant            = var.tenant
  libvirt_admin     = var.libvirt_admin
  libvirt_ip        = var.libvirt_ip
}

variable "masternodes" {
  type    = list(string)
  default = ["main01"]
}

variable "workernodes" {
  type    = list(string)
  default = []
}

variable "libvirt_admin" {
  type = string
}

variable "libvirt_ip" {
  type = string
}

variable "qcow2" {
  type    = string
  default = "https://downloads.volterra.io/releases/images/2021-03-01/centos-7.2009.5-202103011045.qcow2"
  #default    = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030.qcow2"
  #default     = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355.qcow2"
}

variable "cpu" {
  type    = number
  default = 4
}

variable "memory" {
  type    = number
  default = 16384
}

variable "certifiedhardware" {
  type    = string
  default = "kvm-voltstack-combo"
}

variable "latitude" {
  type    = string
  default = "43.650757"
}

variable "longitude" {
  type    = string
  default = "-79.43744"
}

variable "dnsservers" {
  type = map(string)
  default = {
    primary   = "8.8.8.8"
    secondary = "8.8.4.4"
  }
}

variable "clustername" {
  type    = string
  default = "k8s01-tor"
}

variable "k8scluster" {
  type    = string
  default = "k8s-profile"
}

variable "token" {
  type    = string
  default = ""
}

variable "address" {
  type    = string
  default = "26 Margueretta, Toronto Ontario"
}

variable "kvmappstack" {
  type = any
  default = []
}

