resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.labrole.arn

  vpc_config {
    subnet_ids = [
      for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.region_default}e"
    ]
    security_group_ids = [aws_security_group.security_group.id]
  }

  access_config {
    authentication_mode = var.access_config
  }
}