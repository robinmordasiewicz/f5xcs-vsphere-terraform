provider "volterra" {
  api_p12_file = var.VOLT_API_P12_FILE
  url          = "https://jpmc.console.ves.volterra.io/api"
}

provider "libvirt" {
  uri = "qemu:///system"
}

