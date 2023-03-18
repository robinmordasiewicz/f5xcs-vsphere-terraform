variable "VOLT_API_P12_FILE" {
  type = string
}

variable "clustername" {
  default = "k8s02-tor"
}

variable "k8scluster" {
  default = "k8s-profile"
}

variable "masternodes" {
  type    = list(string)
  default = ["main01", "main02", "main03"]
}

variable "workernodes" {
  type    = list(string)
  default = ["worker01" ]
}

locals {
  hostnames = concat(var.masternodes, var.workernodes)
}

variable "address" {
  default = "26 Margueretta, Toronto Ontario"
}

variable "latitude" {
  default = "43.650757"
}

variable "longitude" {
  default = "-79.43744"
}

variable "token" {
  type = string
}

