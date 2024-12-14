output "eks_cluster_name" {
  value = aws_eks_cluster.tc_eks_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.tc_eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.tc_eks_cluster.certificate_authority[0].data
}

output "aws_lb_listener" {
  value = aws_lb_listener.nlb_listener.arn
}

