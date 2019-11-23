resource "kubernetes_cluster_role_binding" "rbDashboardClusterAdmin" {
  metadata {
    name = "dashboard-cluster-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kubernetes-dashboard"
    namespace = "kube-system"
  }
}

resource "kubernetes_namespace" "infra" {
  metadata {
    name = "infra"
  }
}

# Cluster role needed by Spring Cloud Kubernetes to read ConfigMaps to configure a Spring application.
# To use it, define a RoleBinding (not a ClusterRoleBinding) in the project's namespace, binding the 'default' service account in the namespace to this role.
# It is defined as a cluster role so that we don't have to create a role definition per namespace.
resource "kubernetes_cluster_role" "namespaceReader" {
  metadata {
    name = "namespace-reader"
  }

  rule {
    api_groups     = ["", "extensions", "apps"]
    resources      = ["configmaps", "pods", "services", "endpoints", "secrets"]
    verbs          =  ["get", "list", "watch"]
  }
}