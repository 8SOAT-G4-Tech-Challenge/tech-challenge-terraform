resource "kubernetes_namespace" "payment" {
  metadata {
    name = "tech-challenge-payment"
  }
}