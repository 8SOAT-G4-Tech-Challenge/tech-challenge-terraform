data "aws_eks_cluster" "eks_cluster_techchallenge" {
  name = "tech-challenge-cluster"
}

output "eks_cluster_endpoint" {
  value = data.aws_eks_cluster.eks_cluster_techchallenge.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = data.aws_eks_cluster.eks_cluster_techchallenge.certificate_authority[0].data
}

data "aws_eks_cluster_auth" "aws_eks_cluster_auth" {
  name = "tech-challenge-cluster"
}