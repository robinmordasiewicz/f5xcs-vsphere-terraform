variable "hostnames" {
  type    = list(string)
  default = ["main01", "main02", "main03"]
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
  type    = string
}
variable "token" {
  type    = string
}
variable "latitude" {
  type    = string
}
variable "longitude" {
  type    = string
}
variable "qcow2" {
  type    = string
}
variable "memory" {
  default = 16389
}
variable "cpu" {
  default = 4
}
