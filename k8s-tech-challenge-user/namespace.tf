resource "kubernetes_namespace" "user" {
  metadata {
    name = "tech-challenge-user"
  }
}