resource "kubernetes_config_map" "env_config" {
  metadata {
    name      = "env-config-tech-challenge-user"
		namespace = kubernetes_namespace.user.metadata[0].name
    labels = {
      name = "env-config-tech-challenge-user"
    }
  }

  data = {
    API_PORT = "3334"
  }

	depends_on = [kubernetes_namespace.user]
}