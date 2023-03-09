variable "hostnames" {
  type           = list(string)
  default        = ["mains01", "mains02", "mains03"]
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

variable "VOLT_API_CERT" {
  type        = string
  default     = "./api.cer"
}

variable "VOLT_API_KEY" {
  type        = string
  default     = "./api.key"
}

variable "tenant" {
  type        = string
}

variable "datacenter" {
  type        = string
  default     = "Default Datacenter"
}

variable "outside_network" {
  type        = string
  default     = "SLO"
}

variable "inside_network" {
  type        = string
  default     = "SLI"
}

variable "cpus" {
  type        = number
  default     = 4
}

variable "memory" {
  type        = number
  default     = 16384
}

variable "projectName" {
  type        = string
  default     = "project-name"
}

variable "certifiedhardware" {
  type        = string
  default     = "kvm-voltstack-combo"
}

variable "sitelatitude" {
  type        = string
  default     = "30"
}

variable "sitelongitude" {
  type        = string
  default     = "-75"
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
  default     = "coleman-libvirt-cluster"
}

variable "sitetoken" {
  type        = string
  default     = "12345678910"
}

variable "sitename" {
  type        = string
  default     = "adrastea"
}

variable "namespace" {
  type        = string
  default     = "namespace"
}


