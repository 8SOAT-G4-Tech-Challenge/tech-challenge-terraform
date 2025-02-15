variable "order_target_group_arn" {
  description = "AWS Load balancer target group order"
  type        = string
}

variable "payment_target_group_arn" {
  description = "AWS Load balancer target group payment"
  type        = string
}

variable "user_target_group_arn" {
  description = "AWS Load balancer target group user"
  type        = string
}

variable "tc_lb_target_group_network_arn" {
  description = "AWS Load balancer target group network"
  type        = string
}
variable "tc_load_balancer_arn" {
  description = "AWS Load balancer arn"
  type        = string
}
