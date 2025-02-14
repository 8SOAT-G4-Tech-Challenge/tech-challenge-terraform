# Attach instances to the order target group
resource "aws_lb_target_group_attachment" "order_balancer_attach" {
  target_group_arn = var.order_target_group_arn
  target_id        = data.aws_instance.ec2.id
  port             = 31300
}

# Attach instances to the payment target group
resource "aws_lb_target_group_attachment" "payment_balancer_attach" {
  target_group_arn = var.payment_target_group_arn
  target_id        = data.aws_instance.ec2.id
  port             = 31333
}

# Attach instances to the user target group
resource "aws_lb_target_group_attachment" "user_balancer_attach" {
  target_group_arn = var.user_target_group_arn
  target_id        = data.aws_instance.ec2.id
  port             = 31334
}

resource "aws_lb_target_group_attachment" "nlb_alb_attach" {
  target_group_arn = var.tc_lb_target_group_network_arn
  target_id        = var.tc_load_balancer_arn
  port             = 80
}