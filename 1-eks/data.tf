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

data "aws_subnet" "subnet_public_1" {
	tags = {
		Name = "${var.project_name}-public-subnet-1"
		Iac  = true
	}
}

data "aws_subnet" "subnet_public_2" {
	tags = {
		Name = "${var.project_name}-public-subnet-2"
		Iac  = true
	}
}

data "aws_iam_role" "labrole" {
  name = "LabRole"
}

/* data "aws_instance" "ec2" {
    filter {
        name = "tag:eks:nodegroup-name"
        values = ["node-group-tech-challenge"]
    }
} */
data "aws_instances" "instance_eks" {
  filter {
    name   = "tag:kubernetes.io/cluster/${aws_eks_cluster.tc_eks_cluster.name}"
    values = ["owned"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}


