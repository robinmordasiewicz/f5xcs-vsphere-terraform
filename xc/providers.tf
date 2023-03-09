terraform {
  required_version = ">= 0.13"
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.19"
    }
  }
}

provider "volterra" {
  api_p12_file      = var.VOLT_API_P12_FILE
  api_cert          = var.VOLT_API_CERT != "" ? "" : var.VOLT_API_CERT
  api_key           = var.VOLT_API_KEY != "" ? "" : var.VOLT_API_KEY
  url               = var.VOLT_API_URL
}
