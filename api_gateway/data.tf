data "aws_vpc" "vpc" {
  cidr_block = var.vpcCidr
	default = true
}
