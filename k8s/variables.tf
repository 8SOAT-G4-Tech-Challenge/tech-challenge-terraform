variable "cluster_name" {
  description = "AWS EKS cluster name"
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "AWS EKS cluster endpoint"
  type        = string
}

variable "kubeconfig-certificate-authority-data" {
  description = "Kubernetes configuration certificate authority data"
  type        = string
}

