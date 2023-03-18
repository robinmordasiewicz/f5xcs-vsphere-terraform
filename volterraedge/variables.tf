variable "VOLT_API_P12_FILE" {}
variable "VES_P12_PASSWORD" {}
variable "clustername" {}
variable "k8scluster" {}
variable "tenant" {}
variable "masternodes" {}
variable "workernodes" {}
variable "latitude" {}
variable "longitude" {}
variable "address" {}
#variable "token" {}
variable "token" {
  type = string
  default = "4afa7fbe-bf1c-4a2e-9092-0c15cc745c12"
}
variable "libvirt_domain" {
  type = any
  default = []
}
variable "volterradomain" {
  type = any
  default = []
}
locals {
  hostnames = concat(var.masternodes, var.workernodes)
}
