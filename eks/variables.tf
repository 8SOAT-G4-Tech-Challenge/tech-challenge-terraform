variable "region_default" {
  description = "The default region"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "access_config" {
  description = "Access config map"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "policy_arn" {
  description = "AWS EKS cluster access policy"
  type        = string
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "intance_eks_type" {
  description = "AWS EKS instance type"
  type        = string
  default     = "t3a.medium"
}

variable "account_id_voclabs" {}

variable "vpc_cidr" {}

variable "cluster_name" {}