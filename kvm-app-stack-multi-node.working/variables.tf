variable "qcow2" {
  #default = "https://downloads.volterra.io/releases/images/2021-03-01/centos-7.2009.5-202103011045.qcow2"
  default = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355.qcow2"
}

variable "memory" {
  default = "16384"
}

variable "vcpu" {
  default = "4"
}

variable "clustername" {
  default = "k8s02-tor"
}

variable "k8scluster" {
  default = "app1-k8s"
}

variable "hostnames" {
  type    = list(string)
  default = ["mains01", "mains02", "mains03"]
}

variable "storagepool" {
  default = "default"
}

variable "latitude" {
  default = "43.650757"
}

variable "longitude" {
  default = "-79.43744"
}

variable "VOLT_API_P12_FILE" {
  type = string
}

variable "token" {
  type = string
}

variable "pk8s-cluster-role-binding-subjects" {
  default = [""]
}
