resource "aws_lb_target_group_attachment" "tc_balancer_attach" {
  target_group_arn = var.tc_lb_target_group_application_arn
  target_id        = data.aws_instance.ec2.id
  port             = 31333
}

resource "aws_lb_target_group_attachment" "nlb_alb_attach" {
  target_group_arn = var.tc_lb_target_group_network_arn
  target_id        = var.tc_load_balancer_arn
  port             = 80
}