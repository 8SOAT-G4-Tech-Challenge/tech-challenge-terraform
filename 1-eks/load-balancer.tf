# APPLICATION LOAD BALANCER
resource "aws_lb" "tc_load_balancer" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.tc_security_group.id]
  subnets = [data.aws_subnet.subnet_private_1.id, data.aws_subnet.subnet_private_2.id]
  idle_timeout = 60
  tags = {
    Name = "${var.project_name}-eks-alb"
		Iac = true
  }
}

resource "aws_lb_target_group" "tc_lb_target_group" {
  name        = "${var.project_name}-lb-target-group"
  port        = 31333
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
		enabled							= true
    healthy_threshold   = 2
    interval            = 30
    path								= "/users"
    port								= 31333
    matcher							= "200"
		protocol						= "HTTP"
    timeout							= 5
    unhealthy_threshold	= 2
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

/* resource "aws_lb_target_group_attachment" "tc_balancer_attach" {
    target_group_arn = var.tc_lb_target_group_arn
    target_id = ????
    port = 31333
} */

# NETWORK LOAD BALANCER
resource "aws_lb" "network_load_balancer" {
  name               = "${var.project_name}-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = [data.aws_subnet.subnet_private_1.id, data.aws_subnet.subnet_private_2.id]

  tags = {
    Name = "${var.project_name}-nlb"
		Iac = true
  }
}

resource "aws_lb_target_group" "nlb_target" {
  name        = "${var.project_name}-nlb-tg"
  port        = 80
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target.arn
  }
}

/* resource "aws_lb_target_group_attachment" "nlb_alb_attach" {
  target_group_arn = aws_lb_target_group.nlb_target.arn
  target_id        = aws_lb.tc_load_balancer.arn
  port             = 80
} */
