resource "kubernetes_service" "api_tech_challenge_service" {
  metadata {
    name = "api-tech-challenge-service"
    labels = {
      name = "api-tech-challenge-service"
    }
    /* annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"                = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-internal"            = "false"
			"service.beta.kubernetes.io/aws-load-balancer-name"                = "nlb-tech-challenge"
      "service.beta.kubernetes.io/aws-load-balancer-target-group-attributes" = "preserve_client_ip.enabled=true"
      "service.beta.kubernetes.io/aws-load-balancer-target-type"         = "instance"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"              = "internet-facing"
    } */
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