variable "VOLT_API_P12_FILE" {
  type = string
}

variable "clustername" {
  default = "k8s02-tor"
}

variable "k8scluster" {
  default = "k8s-profile"
}

variable "hostnames" {
  type    = list(string)
  default = ["mains01", "mains02", "mains03"]
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

