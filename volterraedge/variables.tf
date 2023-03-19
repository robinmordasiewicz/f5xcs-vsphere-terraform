variable "VOLT_API_P12_FILE" {}
variable "VES_P12_PASSWORD" {}
variable "clustername" {}
variable "k8scluster" {}
variable "masternodes" {}
variable "workernodes" {}
variable "latitude" {}
variable "longitude" {}
variable "address" {}
variable "url" {}
variable "token" {
  type    = string
  default = ""
}
variable "libvirt_domain" {
  type    = any
  default = []
}
variable "volterradomain" {
  type    = any
  default = []
}
variable "kvm" {
    type    = any
    default = []
}
variable "appstacksite" {
    type    = any
    default = []
}
variable "kvmappstack" {
    type    = any
    default = []
}
locals {
  hostnames = concat(var.masternodes, var.workernodes)
}
