resource "kubernetes_config_map" "env_config" {
  metadata {
    name      = "env-config-tech-challenge-order"
    namespace = kubernetes_namespace.order.metadata[0].name
    labels = {
      name = "env-config-tech-challenge-order"
    }
  }

  data = {
    API_PORT = "3000"
  }

  depends_on = [kubernetes_namespace.order]
}