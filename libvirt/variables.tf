variable "hostnames" {
  type    = list(string)
  default = []
}
variable "libvirt_admin" {
  type    = string
  default = "robin"
}
variable "libvirt_ip" {
  type    = string
  default = "192.168.1.95"
}
variable "clustername" {
  type = string
}
variable "token" {
  type    = string
  default = "4afa7fbe-bf1c-4a2e-9092-0c15cc745c12"
}
variable "libvirt_depends_on" {
  type    = any
  default = []
}
variable "latitude" {
  type = string
}
variable "longitude" {
  type = string
}
variable "memory" {
  default = 16389
}
variable "cpu" {
  default = 4
}

variable "qcow2" {
  #default = "https://downloads.volterra.io/releases/images/2021-03-01/centos-7.2009.5-202103011045.qcow2"
  default = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355.qcow2"
}

