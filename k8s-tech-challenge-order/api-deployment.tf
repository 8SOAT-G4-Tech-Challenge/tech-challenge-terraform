resource "kubernetes_deployment" "api_tech_challenge" {
  metadata {
    name      = "api-tech-challenge-order"
    namespace = kubernetes_namespace.order.metadata[0].name
    labels = {
      app = "api-tech-challenge-order"
    }
  }

  spec {
    replicas = 2

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = "50%"
      }
    }

    selector {
      match_labels = {
        app = "api-tech-challenge-order"
      }
    }

    template {
      metadata {
        name = "api-tech-challenge-order"
        namespace = kubernetes_namespace.order.metadata[0].name
        labels = {
          app = "api-tech-challenge-order"
        }
      }

      spec {
        affinity {
          node_affinity {
            required_during_scheduling_ignored_during_execution {
              node_selector_term {
                match_expressions {
                  key      = "kubernetes.io/arch"
                  operator = "In"
                  values   = ["amd64", "arm64"]
                }
              }
            }
          }
        }

        container {
          name              = "api-tech-challenge-order-container"
          image             = "lucasaccurcio/tech-challenge-order-api:latest"
          image_pull_policy = "Always"
          port {
            container_port = 3000
          }

          env_from {
            config_map_ref {
              name = "env-config-tech-challenge-order"
            }
          }

          env {
            name  = "DATABASE_URL"
            value = data.aws_secretsmanager_secret_version.secret-version.secret_string
          }

          env {
            name  = "USER_BASE_URL"
            value = "http://api-tech-challenge-user"
          }

          env {
            name  = "PAYMENT_ORDER_BASE_URL"
            value = "http://api-tech-challenge-payment-service"
          }

          liveness_probe {
            http_get {
              path = "/orders/health"
              port = 3000
            }
            initial_delay_seconds = 60
            period_seconds        = 10
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path = "/orders/health"
              port = 3000
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            failure_threshold     = 5
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }
        }

        node_selector = {
          "kubernetes.io/os" = "linux"
        }
      }
    }
  }

  depends_on = [kubernetes_config_map.env_config]
}