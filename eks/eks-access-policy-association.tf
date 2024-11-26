resource "aws_eks_access_policy_association" "eks_policy" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  policy_arn    = var.policy_arn
  principal_arn = "arn:aws:iam::${var.account_id_voclabs}:role/voclabs"

  access_scope {
    type = "cluster"
  }
}