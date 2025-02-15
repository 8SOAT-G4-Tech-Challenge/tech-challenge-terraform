resource "kubernetes_config_map" "env_config" {
  metadata {
    name      = "env-config-tech-challenge-order"
    labels = {
      name = "env-config-tech-challenge-order"
    }
  }

  data = {
    API_PORT = "3000"
  }
}