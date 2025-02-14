resource "kubernetes_config_map" "env_config" {
  metadata {
    name = "env-config"
    labels = {
      name = "env-config"
    }
  }

  data = {
    API_PORT = "3000"
  }
}