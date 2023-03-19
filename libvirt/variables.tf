variable "hostnames" {
  type    = list(string)
  default = []
}
variable "libvirt_admin" {
  type    = string
  default = ""
}
variable "libvirt_ip" {
  type    = string
  default = ""
}
variable "clustername" {
  type = string
}
variable "appstacksite" {
  type    = any
  default = []
}
variable "token" {
  type    = any
  default = []
}
variable "latitude" {
  type = string
}
variable "longitude" {
  type = string
}
variable "qcow2" {
  default = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355.qcow2"
}
variable "kvmappstack" {
  type    = any
  default = []
}
