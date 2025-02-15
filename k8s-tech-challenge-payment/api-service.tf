resource "kubernetes_service" "api_tech_challenge_payment_service" {
  metadata {
    name      = "api-tech-challenge-payment-service"
    namespace = kubernetes_namespace.payment.metadata[0].name
    labels = {
      name = "api-tech-challenge-payment-service"
    }
  }

  spec {
    type = "NodePort"

    selector = {
      app = "api-tech-challenge-payment"
    }

    port {
      name        = "api-port"
      protocol    = "TCP"
      port        = 80
      target_port = 3333
      node_port   = 31333
    }
  }

  depends_on = [kubernetes_deployment.api_tech_challenge_payment]
}