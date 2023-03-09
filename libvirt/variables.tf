variable "hostnames" {
  type    = list(string)
  default = ["mains01", "mains02", "mains03"]
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
