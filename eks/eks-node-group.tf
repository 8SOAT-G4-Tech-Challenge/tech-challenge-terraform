resource "aws_eks_node_group" "tc_node_group" {
  cluster_name    = aws_eks_cluster.tc_eks_cluster.name
  node_group_name = "node-group-${var.tech_challenge_project_name}"
  node_role_arn   = data.aws_iam_role.labrole.arn
  subnet_ids = [
    for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.region_default}e"
  ]
  disk_size      = 50
  instance_types = [var.intance_eks_type]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}