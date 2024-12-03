module "eks" {
  source             = "./eks"
  account_id_voclabs = var.account_id_voclabs
  cluster_name       = var.tech-challenge-cluster
  vpcCidr            = var.vpcCidr
}

module "k8s" {
  source                                = "./k8s"
  kubeconfig-certificate-authority-data = module.eks.kubeconfig-certificate-authority-data
  cluster_name                          = module.eks.eks_cluster_name
  eks_cluster_endpoint                  = module.eks.eks_cluster_endpoint
  depends_on                            = [module.eks]
}

module "lb" {
  source                 = "./lb"
  tc_lb_target_group_arn = module.eks.tc_lb_target_group_arn
  depends_on             = [module.k8s]
}