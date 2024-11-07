resource "aws_launch_template" "ec2_lt" {
  name_prefix = "ecs-template"
  image_id = "ami-0c45946ade6066f3d"
  instance_type = "t2.micro"
  key_name = "tech-challenge-ecs2-key"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      name="ecs_instance"
    }
  }
  user_data = filebase64("${path.module}/ecs.sh")
}