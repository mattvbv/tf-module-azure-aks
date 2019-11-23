resource "kubernetes_service_account" "fluentdsa" {
  metadata {
    name = "fluentdsa"
    namespace = "${kubernetes_namespace.infra.metadata[0].name}"
  }
}

resource "kubernetes_cluster_role" "fluentdClusterRole" {
  metadata {
    name = "fluentd-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "fluentdClusterRoleBinding" {
  metadata {
    name = "fluentd-cluster-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "${kubernetes_cluster_role.fluentdClusterRole.metadata[0].name}"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.fluentdsa.metadata[0].name}"
    namespace = "${kubernetes_namespace.infra.metadata[0].name}"
  }
}

resource "kubernetes_config_map" "fluentdConfigMap" {
  metadata {
    name = "fluentd-fluentconf"
    namespace = "${kubernetes_namespace.infra.metadata[0].name}"
  }

  data = {
    "fluentd.conf" = "${file("${path.module}/files/fluentd-conf-fluentd.conf")}"
  }
}

resource "kubernetes_config_map" "fluentdKubernetesConfigMap" {
  metadata {
    name = "fluentd-kubernetesconf"
    namespace = "${kubernetes_namespace.infra.metadata[0].name}"
  }

  data = {
    "kubernetes.conf" = "${file("${path.module}/files/fluentd-conf-kubernetes.conf")}"
  }
}

resource "kubernetes_daemonset" "fluentdDaemonSet" {
  metadata {
    name      = "fluentd"
    namespace = "${kubernetes_namespace.infra.metadata[0].name}"
    labels = {
      k8s-app = "fluentd-logging"
    }
  }

  spec {
    selector {
      match_labels = {
        k8s-app = "fluentd-logging"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app = "fluentd-logging"
        }
      }

      spec {
        container {
          image = var.fluentd_container_image
          name  = "fluentd"

          env {
            name = "FLUENT_ELASTICSEARCH_HOST"
            value = var.fluentd_elasticsearch_host
          }
          env {
            name = "FLUENT_ELASTICSEARCH_PORT"
            value = var.fluentd_elasticsearch_port
          }          
          env {
            name = "FLUENT_ELASTICSEARCH_SCHEME"
            value = var.fluentd_elasticsearch_scheme
          } 

          env {
            name = "FLUENT_UID"
            value = "0"
          }
          env {
            name = "FLUENT_ELASTICSEARCH_SED_DISABLE"
            value = "true"
          }                           
          security_context {
            privileged = true
          }

          resources {
            limits {
              memory = "500Mi"
            }
            requests {
              cpu    = "500m"
              memory = "200Mi"
            }
          }
          volume_mount {
            mount_path = "/var/log"
            name       = "varlog"
          }
          volume_mount {
            mount_path = "/var/lib/docker/containers"
            name       = "varlibdockercontainers"
            read_only = true
          }          
          volume_mount {
            mount_path = "/fluentd/etc/fluent.conf"
            name       = "fluentd-fluentconf"
            sub_path = "fluentd.conf"
          }
          volume_mount {
            mount_path = "/fluentd/etc/kubernetes.conf"
            name       = "fluentd-kubernetesconf"
            sub_path = "kubernetes.conf"
          }                    
        }

        automount_service_account_token = true
        service_account_name = "fluentdsa"

        volume {
          name = "varlog"
          host_path {
            path = "/var/log"
          }
        }
        volume {
          name = "varlibdockercontainers"
          host_path {
            path = "/var/lib/docker/containers"
          }
        }
        volume {
          name = "fluentd-fluentconf"
          config_map {
            default_mode = "0420"
            name = "fluentd-fluentconf"
          }
        }
        volume {
          name = "fluentd-kubernetesconf"
          config_map {
            default_mode = "0420"
            name = "fluentd-kubernetesconf"
          }
        }                 
      }
    }
  }
}