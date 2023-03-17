resource "helm_release" "argocd" {
  name       = "argocd"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "argo-cd"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
