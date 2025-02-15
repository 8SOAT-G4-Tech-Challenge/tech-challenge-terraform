resource "kubernetes_service" "api_tech_challenge_order_service" {
  metadata {
    name      = "api-tech-challenge-order-service"
    namespace = kubernetes_namespace.order.metadata[0].name
    labels = {
      name = "api-tech-challenge-order-service"
    }
  }

  spec {
    type = "NodePort"

    selector = {
      app = "api-tech-challenge-order"
    }

    port {
      name        = "api-port"
      protocol    = "TCP"
      port        = 80
      target_port = 3000
      node_port   = 31300
    }
  }

  depends_on = [kubernetes_deployment.api_tech_challenge]
}