terraform {
  required_version = ">= 0.13"
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.19"
    }
    libvirt = {
      source     = "dmacvicar/libvirt"
      version    = "0.7.1"
    }
  }
}

provider "volterra" {
  VOLT_API_P12_FILE = var.VOLT_API_P12_FILE
  api_cert          = var.VOLT_API_P12_FILE != "" ? "" : var.api_cert
  api_key           = var.VOLT_API_P12_FILE != "" ? "" : var.api_key
  url               = var.api_url
}

provider "libvirt" {
  uri     = "qemu+ssh://${var.libvirt_admin}@${var.libvirt_ip}/system?sshauth=privkey&no_verify=1"
}
