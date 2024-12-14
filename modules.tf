module "eks" {
  source = "./eks"

  account_id_voclabs = var.account_id_voclabs
  cluster_name       = var.cluster_name
  vpc_cidr           = var.vpc_cidr
  region_default     = var.region_default
  project_name       = var.project_name
}

module "k8s" {
  source = "./k8s"

  kubeconfig-certificate-authority-data = module.eks.kubeconfig-certificate-authority-data
  cluster_name                          = module.eks.eks_cluster_name
  eks_cluster_endpoint                  = module.eks.eks_cluster_endpoint
  depends_on                            = [module.eks]
}

module "load-balancer" {
  source = "./load-balancer"

  tc_lb_target_group_application_arn    = module.eks.tc_lb_target_group_application_arn
  tc_lb_target_group_network_arn        = module.eks.tc_lb_target_group_network_arn
  tc_load_balancer_arn                  = module.eks.tc_load_balancer_arn
  depends_on                            = [module.k8s]
}

module "cognito" {
  source = "./cognito"

  project_name        = var.project_name
  admin_user_email    = var.admin_user_email
  admin_user_password = var.admin_user_password

  depends_on = [module.eks, module.k8s]
}

module "api_gateway" {
  source = "./api_gateway"

  project_name   = var.project_name
  region_default = var.region_default
  aws_account_id = var.account_id_voclabs

  lb_listener_arn      = module.eks.aws_lb_listener
  cognito_client_id    = module.cognito.admin_client_id
  cognito_user_pool_id = module.cognito.user_pool_id

  depends_on = [module.cognito, module.k8s]
}