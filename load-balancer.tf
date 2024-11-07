resource "aws_lb" "ecs_alb" {
  name = "tech-challenge-ecs-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.security_group.id]
  subnets = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id
  ]
  tags = {
    name="ecs-alb"
  }
}

resource "aws_lb_target_group" "ecs_alb_tg" {
  name = "webapp-tg"
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.main.id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs_alb_tg.arn
  }
}