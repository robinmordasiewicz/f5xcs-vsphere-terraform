data "volterra_namespace" "system" {
  name = "system"
}

resource "volterra_k8s_cluster_role" "allow_all" {
  #name        = format("%s-allow-all", var.k8scluster)
  name        = "admin"
  namespace   = data.volterra_namespace.system.name

  policy_rule_list {
    policy_rule {
      resource_list {
        api_groups      = ["*"]
        resource_types  = ["*"]
        verbs           = ["*"]
      }
    }
  }
}

resource "volterra_k8s_cluster_role_binding" "argocd_crb1" {
  #name        = format("%s-argocd1-cluster-role-binding", var.k8scluster)
  name = "argocd-crb1"
  namespace   = data.volterra_namespace.system.name

  k8s_cluster_role {
    name      = volterra_k8s_cluster_role.allow_all.name
    namespace = data.volterra_namespace.system.name
  }

  subjects {
    service_account {
      name = "argocd-application-controller"
      namespace = data.volterra_namespace.system.name
    }
  }
}

resource "volterra_k8s_cluster_role_binding" "argocd_crb2" {
  #name        = format("%s-argocd2-cluster-role-binding", var.k8scluster)
  name = "argocd-crb2"
  namespace   = data.volterra_namespace.system.name

  k8s_cluster_role {
    name      = volterra_k8s_cluster_role.allow_all.name
    namespace = data.volterra_namespace.system.name
  }

  subjects {
    user = "admin"
  }

}

resource "volterra_k8s_cluster" "pk8s_cluster" {
  #name        = format("%s-pk8s-cluster", var.clustername)
  name        = var.k8scluster
  namespace   = data.volterra_namespace.system.name

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
      #namespace = data.volterra_namespace.system.name
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

  global_access_enable         = true
  cluster_scoped_access_permit = true
  no_cluster_wide_apps         = true
  no_insecure_registries       = true
  use_default_psp              = true
}

resource "volterra_voltstack_site" "pk8s_voltstack_site" {
  depends_on = [
    volterra_k8s_cluster.pk8s_cluster
  ]
  name                  = var.clustername
  namespace             = data.volterra_namespace.system.name
  #labels = ["ves.io/provider=ves-io-VMWARE"]
  labels = {
      "ves.io/provider" = "ves-io-VMWARE"
  }

  volterra_certified_hw = "kvm-voltstack-combo"
  master_nodes          = [ "${var.hostname}" ]

  k8s_cluster {
    name      = volterra_k8s_cluster.pk8s_cluster.name
    namespace = data.volterra_namespace.system.name
    tenant    = data.volterra_namespace.system.tenant_name
  }

  lifecycle {
    ignore_changes = [labels]
  }

  sw {
    default_sw_version = true
  }

  os {
    default_os_version = true
  }

  no_bond_devices         = true
  disable_gpu             = true
  logs_streaming_disabled = true
  default_network_config  = true
  default_storage_config  = true
  deny_all_usb            = true
}

resource "volterra_registration_approval" "node-registration" {
  depends_on   = [ libvirt_domain.kvm-app-stack ]

  cluster_name = var.clustername
  hostname     = var.hostname
  cluster_size = 1
  retry        = 5
  wait_time    = 60
}
