terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source     = "dmacvicar/libvirt"
      version    = "0.7.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.19"
    }
  }
}

provider "volterra" {
  api_p12_file = var.api_p12_file
  api_cert     = var.api_p12_file != "" ? "" : var.api_cert
  api_key      = var.api_p12_file != "" ? "" : var.api_key
  url          = var.api_url
}

provider "http" {
}

provider "libvirt" {
  uri            = var.libvirt_uri
}

