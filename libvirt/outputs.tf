output "name" {
  value = libvirt_domain.kvm-app-stack[*].name
}
