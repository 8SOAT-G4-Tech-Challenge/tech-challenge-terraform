output "eks_cluster_name" {
    value = aws_eks_cluster.tc_eks_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.tc_eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.tc_eks_cluster.certificate_authority[0].data
}

output "tc_lb_target_group_arn" {
  value = aws_lb_target_group.tc_lb_target_group.arn
}

output "aws_lb_listener" {
	value = aws_lb_listener.tc_lb_listener.arn
}