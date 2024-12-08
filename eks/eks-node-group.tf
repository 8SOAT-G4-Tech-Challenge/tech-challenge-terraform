# Create launch template
resource "aws_launch_template" "eks_node" {
  name = "launch-template-${var.tech_challenge_project_name}"

	vpc_security_group_ids = [aws_security_group.tc_security_group.id]

	# image_id = data.aws_ami.eks.id
	instance_type = var.intance_eks_type

  /* network_interfaces {
    security_groups = [aws_security_group.tc_security_group.id]
    associate_public_ip_address = false
  } */

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
      Name = "EKS-MANAGED-NODE"
    }
  }
}

resource "aws_eks_node_group" "tc_node_group" {
  cluster_name    = aws_eks_cluster.tc_eks_cluster.name
  node_group_name = "node-group-${var.tech_challenge_project_name}"
  node_role_arn   = data.aws_iam_role.labrole.arn

  subnet_ids = [
		aws_subnet.private_subnet_1.id,
		aws_subnet.private_subnet_2.id
	]
  # instance_types = [var.intance_eks_type]

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