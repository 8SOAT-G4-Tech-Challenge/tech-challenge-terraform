resource "aws_eks_access_entry" "eks_access_entry" {
  cluster_name      = aws_eks_cluster.eks_cluster.name
  principal_arn     = "arn:aws:iam::${var.account_id_voclabs}:role/voclabs"
  kubernetes_groups = ["tech-challenge"]
  type              = "STANDARD"
}