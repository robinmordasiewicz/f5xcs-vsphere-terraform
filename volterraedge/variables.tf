variable "VOLT_API_P12_FILE" {}
variable "VES_P12_PASSWORD" {}
variable "namespace" {}
variable "clustername" {}
variable "tenant" {}
variable "hostnames" {}
variable "latitude" {}
variable "longitude" {}
variable "address" {
  type = string
}
variable "token" {
  type = any
  default = []
}
variable "libvirt_domain" {
  type = any
  default = []
}
variable "volterradomain" {
  type = any
  default = []
}
