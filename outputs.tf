output "completion_time" {
  description = "Outputs the time of script completion.  Just for auditing purposes."
  value       = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

output "hostnames" {
  value = local.hostnames
}

output "appstacksite" {
  value = module.volterraedge.appstacksite
}

output "kvmappstack" {
   value = module.libvirt.kvmappstack[*]
}
