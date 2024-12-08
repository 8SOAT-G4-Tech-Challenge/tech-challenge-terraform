variable tech_challenge_project_name {
	description = "The name of the project"
	type        = string
}

variable region_default {
	description = "The default region"
	type        = string
}

/* variable nlb_hostname {
	description = "The DNS of the NLB created by the EKS module"
	type        = string
} */

variable "vpcCidr" {}

variable "private_subnet_ids" {
	type = list(string)
}

/* variable "lb_name" {
  type    = string
  default = "nlb-tech-challenge"
} */

/* variable "loadbalancer_metadata" {} */
# variable "load_balancer_ingress" {}

variable "nlb_listener_arn" {}

