resource "aws_eks_cluster" "tc_eks_cluster" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.labrole.arn

  vpc_config {
    subnet_ids = [data.aws_subnet.subnet_private_1.id, data.aws_subnet.subnet_private_2.id]
    security_group_ids = [data.aws_security_group.tc_security_group.id]
		endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs    = ["0.0.0.0/0"]
  }

  access_config {
    authentication_mode = var.access_config
  }
}