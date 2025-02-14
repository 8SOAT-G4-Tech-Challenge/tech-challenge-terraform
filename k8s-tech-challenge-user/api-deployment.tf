resource "kubernetes_deployment" "api_tech_challenge" {
  metadata {
    name = "api-tech-challenge-user"
    labels = {
      app = "api-tech-challenge-user"
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
        app = "api-tech-challenge-user"
      }
    }

    template {
      metadata {
        name = "api-tech-challenge-user"
        labels = {
          app = "api-tech-challenge-user"
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
          name              = "api-tech-challenge-user-container"
          image             = "lucasaccurcio/tech-challenge-user-api:latest"
          image_pull_policy = "Always"
          port {
            container_port = 3334
          }

          env_from {
            config_map_ref {
              name = "env-config"
            }
          }

          env {
            name  = "DATABASE_URL"
            value = data.aws_secretsmanager_secret_version.secret-version.secret_string
          }

          env {
            name  = "REDIS_URL"
            value = "redis://${data.aws_elasticache_cluster.redis_cluster.cache_nodes.0.address}:${data.aws_elasticache_cluster.redis_cluster.cache_nodes.0.port}"
          }

          liveness_probe {
            http_get {
              path = "/docs"
              port = 3334
            }
            initial_delay_seconds = 60
            period_seconds        = 10
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path = "/docs"
              port = 3334
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