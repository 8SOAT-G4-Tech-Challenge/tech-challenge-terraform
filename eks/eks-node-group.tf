# Create launch template
resource "aws_launch_template" "eks_node" {
  name = "${var.project_name}-launch-template"

  instance_type = var.intance_eks_type

  network_interfaces {
    security_groups             = [data.aws_security_group.tc_security_group.id]
    associate_public_ip_address = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 50
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-eks-node-instance"
    }
  }
}

resource "aws_eks_node_group" "tc_node_group" {
  cluster_name    = aws_eks_cluster.tc_eks_cluster.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = data.aws_iam_role.labrole.arn

  subnet_ids = [data.aws_subnet.subnet_private_1.id, data.aws_subnet.subnet_private_2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  launch_template {
    id      = aws_launch_template.eks_node.id
    version = aws_launch_template.eks_node.latest_version
  }
}