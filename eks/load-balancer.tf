resource "aws_lb" "tc_load_balancer" {
  name               = "alb-${var.tech_challenge_project_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tc_security_group.id]
  subnets = [
    for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.region_default}e"
  ]
  idle_timeout = 60
  tags = {
    name = "eks-alb"
  }
}

resource "aws_lb_target_group" "tc_lb_target_group" {
  name        = "lb-target-group-${var.tech_challenge_project_name}"
  port        = 30007
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
    path    = "/"
    port    = 30007
    matcher = "200"
  }
}

resource "aws_lb_listener" "tc_lb_listener" {
  load_balancer_arn = aws_lb.tc_load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tc_lb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "tc_balancer_attach" {
    target_group_arn = aws_lb_target_group.tc_lb_target_group.arn
    target_id = data.aws_instance.ec2.id
    port = 30007
    depends_on = [ aws_eks_node_group.tc_node_group ]
}