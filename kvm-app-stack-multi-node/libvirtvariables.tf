variable "qcow2" {
  #default = "https://downloads.volterra.io/releases/images/2021-03-01/centos-7.2009.5-202103011045.qcow2"
  default = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355.qcow2"
}

variable "memory" {
  default = "16384"
}

variable "cpu" {
  default = "4"
}

variable "storagepool" {
  default = "default"
}

