data "aws_vpc" "vpc" {
  tags = {
		Name = "${var.project_name}-vpc"
		Iac = true
	}
}

data "aws_internet_gateway" "default-igw" {
  tags = {
		Name = "${var.project_name}-igw"
		Iac = true
	}
}

data "aws_security_group" "tc_security_group" {
  tags = {
		Name = "${var.project_name}-sg"
		Iac = true
	}
}

data "aws_subnet" "subnet_private_1" {
  tags = {
    Name = "${var.project_name}-private-subnet-1"
		Iac  = true
	}
}

data "aws_subnet" "subnet_private_2" {
	tags = {
		Name = "${var.project_name}-private-subnet-2"
		Iac  = true
	}
}
# Get all private subnets
# data "aws_subnets" "private" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc.id]
#   }

#   tags = {
#     Name = "*private*"
#     Iac  = "true"
#   }
# }

# Get all public subnets
# data "aws_subnets" "public" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc.id]
#   }

#   tags = {
#     Name = "*public*"
#     Iac  = "true"
#   }
# }

data "aws_iam_role" "labrole" {
  name = "LabRole"
}
