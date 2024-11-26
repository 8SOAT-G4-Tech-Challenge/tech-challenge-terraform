resource "aws_lb" "alb" {
  name               = "alb-${var.tech_challenge_project_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group.id]
  subnets = [
    for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.region_default}e"
  ]
  idle_timeout = 60
  tags = {
    name = "eks-alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "tg-${var.tech_challenge_project_name}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}