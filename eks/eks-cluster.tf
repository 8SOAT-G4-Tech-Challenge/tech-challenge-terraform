resource "aws_eks_cluster" "tc_eks_cluster" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.labrole.arn

  vpc_config {
    subnet_ids = [
      for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.region_default}e"
    ]
    security_group_ids = [aws_security_group.tc_security_group.id]
		endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs    = ["0.0.0.0/0"]
  }

  access_config {
    authentication_mode = var.access_config
  }

	depends_on = [
    aws_security_group.tc_security_group
  ]
}