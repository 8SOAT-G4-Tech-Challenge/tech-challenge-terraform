resource "kubernetes_deployment" "api_tech_challenge_payment" {
  metadata {
    name      = "api-tech-challenge-payment"
    labels = {
      app = "api-tech-challenge-payment"
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
        app = "api-tech-challenge-payment"
      }
    }

    template {
      metadata {
        name = "api-tech-challenge-payment"
        labels = {
          app = "api-tech-challenge-payment"
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
          name              = "api-tech-challenge-payment-container"
          image             = "lucasaccurcio/tech-challenge-payment-api:latest"
          image_pull_policy = "Always"
          port {
            container_port = 3333
          }

          env_from {
            config_map_ref {
              name = "env-config-tech-challenge-payment"
            }
          }

          env {
            name  = "DATABASE_URL"
            value = data.aws_secretsmanager_secret_version.secret-version.secret_string
          }

          env {
            name  = "ORDER_BASE_URL"
            value = "http://api-tech-challenge-order-service"
          }

          liveness_probe {
            http_get {
              path = "/totem/payment-orders/e10adc3949ba59abbe56e057f20f883e"
              port = 3333
            }
            initial_delay_seconds = 60
            period_seconds        = 10
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path = "/totem/payment-orders/e10adc3949ba59abbe56e057f20f883e"
              port = 3333
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