resource "aws_lb_target_group_attachment" "tc_balancer_attach" {
    target_group_arn = var.tc_lb_target_group_arn
    target_id = data.aws_instance.ec2.id
    port = 31333
}