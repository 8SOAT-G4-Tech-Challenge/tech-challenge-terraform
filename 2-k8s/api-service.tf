resource "kubernetes_service" "api_tech_challenge_service" {
  metadata {
    name = "api-tech-challenge-service"
    labels = {
      name = "api-tech-challenge-service"
    }
  }

  spec {
    type = "NodePort"

    selector = {
      app = "api-tech-challenge"
    }

    port {
      name        = "api-port"
      protocol    = "TCP"
      port        = 80
      target_port = 3333
			node_port	 = 31333
    }
  }

  depends_on = [kubernetes_deployment.api_tech_challenge]
}