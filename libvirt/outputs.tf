output "kvmappstack" {
  value = libvirt_domain.kvmappstack[*].name
}
