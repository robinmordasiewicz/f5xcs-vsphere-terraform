
resource "volterra_k8s_cluster" "appstackk8s" {
  name                              = var.clustername
  namespace                         = "system"
  no_cluster_wide_apps              = true
  use_default_cluster_role_bindings = true
  use_default_cluster_roles         = true
  cluster_scoped_access_permit      = true
  # cluster_scoped_access_deny      = true
  global_access_enable              = true
  #no_insecure_registries            = true
  insecure_registry_list {
    insecure_registries    = ["example.com:5000"]
  }
  local_access_config {
    local_domain           = "example.com"
    default_port           = true
  }
  use_default_psp          = true
}

resource "volterra_voltstack_site" "appstacksite" {
  name                     = var.clustername
  depends_on = [
    volterra_k8s_cluster.appstackk8s
  ]
  namespace                = "system"
  default_blocked_services = true
  no_bond_devices          = true
  disable_gpu              = true
  k8s_cluster {
    namespace              = "system"
    name                   = var.clustername
  }
  master_nodes             = ["main01","main02","main03"]
  logs_streaming_disabled  = true
  default_network_config   = true
  default_storage_config   = true
  deny_all_usb             = true
  volterra_certified_hw    = "kvm-volstack-combo"
  address                  = "26 Margueretta Street Toronto Ontario"
  coordinates {
    latitude = var.latitude
    longitude = var.longitude
  }
  offline_survivability_mode {
      enable_offline_survivability_mode = true
  }
}

#resource "volterra_registration_approval" "approvalone" {
#  count        = length(var.hostnames)
#  cluster_name = "acmecorp-web"
#  hostname     = var.hostnames[count.index]
#  cluster_size = length(var.hostnames)
#  retry        = 5
#  wait_time    = 300
#  latitude     = 43.650757
#  longitude    = -79.43744
#}

