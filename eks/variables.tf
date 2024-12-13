variable "region_default" {
  default = "us-east-1"
}

variable "project_name" {
  default = "tech-challenge"
}

variable "access_config" {
  default = "API_AND_CONFIG_MAP"
}

variable "policy_arn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "intance_eks_type" {
  default = "t3a.medium"
}

variable "account_id_voclabs" {}

variable "vpc_cidr" {}

variable "cluster_name" {}