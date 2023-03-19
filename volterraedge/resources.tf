
data "volterra_namespace" "system" {
  name = "system"
}

resource "volterra_token" "token" {
  name      = "token"
  namespace = data.volterra_namespace.system.name
}

resource "volterra_k8s_cluster_role" "allow_all" {
  name      = "admin"
  namespace = data.volterra_namespace.system.name
  policy_rule_list {
    policy_rule {
      resource_list {
        api_groups     = ["*"]
        resource_types = ["*"]
        verbs          = ["*"]
      }
    }
  }
}

resource "volterra_k8s_cluster_role_binding" "argocd_crb1" {
  name      = "argocd-crb1"
  namespace = data.volterra_namespace.system.name
  k8s_cluster_role {
    name      = volterra_k8s_cluster_role.allow_all.name
    namespace = data.volterra_namespace.system.name
  }
  subjects {
    service_account {
      name      = "argocd-application-controller"
      namespace = data.volterra_namespace.system.name
    }
  }
}

resource "volterra_k8s_cluster_role_binding" "argocd_crb2" {
  name      = "argocd-crb2"
  namespace = data.volterra_namespace.system.name
  k8s_cluster_role {
    name      = volterra_k8s_cluster_role.allow_all.name
    namespace = data.volterra_namespace.system.name
  }
  subjects {
    user = "admin"
  }
}

resource "volterra_k8s_cluster" "appstackk8s" {
  name                              = var.clustername
  namespace                         = "system"
  no_cluster_wide_apps              = true
  use_default_cluster_role_bindings = true
  use_default_cluster_roles         = true
  cluster_scoped_access_permit      = true
  global_access_enable              = true
  local_access_config {
    local_domain = "${var.clustername}.local"
    default_port = true
  }

  use_custom_cluster_role_list {
    cluster_roles {
      name      = volterra_k8s_cluster_role.allow_all.name
      namespace = data.volterra_namespace.system.name
    }

    cluster_roles {
      name      = "ves-io-admin-cluster-role"
      namespace = "shared"
      tenant    = "ves-io"
    }
  }

  use_custom_cluster_role_bindings {
    cluster_role_bindings {
      name      = volterra_k8s_cluster_role_binding.argocd_crb1.name
      namespace = data.volterra_namespace.system.name
    }
    cluster_role_bindings {
      name      = volterra_k8s_cluster_role_binding.argocd_crb2.name
      namespace = data.volterra_namespace.system.name
    }
  }

  insecure_registry_list {
    insecure_registries = ["example.com:5000"]
  }
  use_default_psp = true
}

resource "volterra_voltstack_site" "appstacksite" {
  name = var.clustername
  labels = {
    "ves.io/provider" = "ves-io-VMWARE"
  }
  namespace                = "system"
  default_blocked_services = true
  no_bond_devices          = true
  disable_gpu              = true
  k8s_cluster {
    namespace = "system"
    name      = volterra_k8s_cluster.appstackk8s.name
  }
  master_nodes            = var.masternodes
  worker_nodes            = var.workernodes
  logs_streaming_disabled = true
  default_network_config  = true
  default_storage_config  = true
  deny_all_usb            = true
  volterra_certified_hw   = "kvm-volstack-combo"
  address                 = var.address
  coordinates {
    latitude  = var.latitude
    longitude = var.longitude
  }
  offline_survivability_mode {
    enable_offline_survivability_mode = true
  }
}

resource "volterra_registration_approval" "node-registration" {
  depends_on = [
    volterra_voltstack_site.appstacksite
  ]
  count        = length(local.hostnames)
  cluster_name = var.clustername
  hostname     = local.hostnames[count.index]
  cluster_size = length(local.hostnames)
  retry        = 10
  wait_time    = 61
}

