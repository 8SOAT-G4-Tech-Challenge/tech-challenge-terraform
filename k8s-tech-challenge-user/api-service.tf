resource "kubernetes_service" "api_tech_challenge_service" {
  metadata {
    name      = "api-tech-challenge-user-service"
		# namespace = kubernetes_namespace.user.metadata[0].name
    labels = {
      name = "api-tech-challenge-user-service"
    }
  }

  spec {
    type = "NodePort"

    selector = {
      app = "api-tech-challenge-user"
    }

    port {
      name        = "api-port"
      protocol    = "TCP"
      port        = 80
      target_port = 3334
      node_port   = 31334
    }
  }

  depends_on = [kubernetes_deployment.api_tech_challenge]
}