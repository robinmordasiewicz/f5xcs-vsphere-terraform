output "name" {
  value = libvirt_domain.kvmappstack[*].name
}
