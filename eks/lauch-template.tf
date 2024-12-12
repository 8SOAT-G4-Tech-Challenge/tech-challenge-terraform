resource "aws_launch_template" "eks_node_launch_template" {
  name_prefix   = "eks-node-launch-template-tech-challenge"
  image_id = "ami-0281f648d3971b0fd"
  instance_type = var.intance_eks_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.tc_security_group.id]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 50
      volume_type = "gp2"
    }
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              /etc/eks/bootstrap.sh ${var.cluster_name}
              EOF
            )
}