resource "kubernetes_namespace" "k8s_namespace" {
  metadata {
    annotations = {
      name = "tech-challenge-group-4"
    }

    labels = {
      mylabel = "tech-challenge-group-4"
    }

    name = "tech-challenge-group-4"
  }
}