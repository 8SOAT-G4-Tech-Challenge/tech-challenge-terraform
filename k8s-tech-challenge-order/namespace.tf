resource "kubernetes_namespace" "order" {
  metadata {
    name = "tech-challenge-order"
  }
}