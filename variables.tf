variable "masternodes" {
  type    = list(string)
  default = ["main01", "main02", "main03"]
}

variable "workernodes" {
  type    = list(string)
  default = ["worker01" ]
}

variable "libvirt_admin" {
  type        = string
}

variable "libvirt_ip" {
  type        = string
}

variable "VOLT_API_P12_FILE" {
  type        = string
}

variable "VES_P12_PASSWORD" {
  type        = string
}

variable "tenant" {
  type        = string
}

variable "qcow2" {
  type        = string
  default     = "https://downloads.volterra.io/releases/images/2021-03-01/centos-7.2009.5-202103011045.qcow2"
  #default    = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202211040823.1667791030.qcow2"
  #default     = "/var/lib/libvirt/templates/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355/vsb-ves-ce-certifiedhw-generic-production-centos-7.2009.27-202302150737.1676454355.qcow2"
}

variable "cpu" {
  type        = number
  default     = 4
}

variable "memory" {
  type        = number
  default     = 16384
}

variable "certifiedhardware" {
  type        = string
  default     = "kvm-voltstack-combo"
}

variable "latitude" {
  type        = string
  default     = "43.650757"
}

variable "longitude" {
  type        = string
  default     = "-79.43744"
}

variable "dnsservers" {
  type        = map(string)
  default = {
    primary   = "8.8.8.8"
    secondary = "8.8.4.4"
  }
}

variable "clustername" {
  type        = string
  default     = "k8s01-tor"
}

variable "k8scluster" {
  type        = string
  default = "k8s-profile"
}

#variable "token" {
#  type = any
#  default = []
#}
variable "token" {
  type = string
  default = "4afa7fbe-bf1c-4a2e-9092-0c15cc745c12"
}

variable "address" {
  type       = string
  default    = ""
}

variable "libvirt_depends_on" {
  type = any
  default = []
}
