resource "aws_security_group" "tc_security_group" {
  name        = "security-group-${var.tech_challenge_project_name}"
  description = "Exclusive security group work tech challenge"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "any"
  }

	ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpcCidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "any"
  }
}

# Create private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = data.aws_vpc.vpc.id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "${var.region_default}a"

  tags = {
    Name = "private-subnet-1-${var.tech_challenge_project_name}"
		"kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = data.aws_vpc.vpc.id
  cidr_block        = "172.31.112.0/20"
  availability_zone = "${var.region_default}b"

  tags = {
    Name = "private-subnet-2-${var.tech_challenge_project_name}"
		"kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "public_subnet_1" {
	vpc_id            = data.aws_vpc.vpc.id
	cidr_block        = "172.31.128.0/20"
	availability_zone = "${var.region_default}a"
	map_public_ip_on_launch = true

	tags = {
		Name = "public-subnet-1-${var.tech_challenge_project_name}"
		"kubernetes.io/role/elb" = "1"
		"kubernetes.io/cluster/demo" = "owned"
	}
}

resource "aws_subnet" "public_subnet_2" {
	vpc_id            = data.aws_vpc.vpc.id
	cidr_block        = "172.31.144.0/20"
	availability_zone = "${var.region_default}b"
	map_public_ip_on_launch = true

	tags = {
		Name = "public-subnet-2-${var.tech_challenge_project_name}"
		"kubernetes.io/role/elb" = "1"
		"kubernetes.io/cluster/demo" = "owned"
	}
}

# Create NAT Gateway (requires public subnet and EIP)
resource "aws_eip" "nat" {
  domain = "vpc"
	# vpc 	= true

	tags = {
		Name = "nat-eip-${var.tech_challenge_project_name}"
	}
}

resource "aws_nat_gateway" "k8s-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "k8s-nat-gateway-${var.tech_challenge_project_name}"
  }
}

# Create route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.k8s-nat.id
  }

  tags = {
    Name = "private-rt-${var.tech_challenge_project_name}"
  }
}

# Create route table for public subnets
resource "aws_route_table" "public" {
	vpc_id = data.aws_vpc.vpc.id

	route {
      cidr_block	= "0.0.0.0/0"
      gateway_id	= data.aws_internet_gateway.default-igw.id
    }

  tags = {
    Name = "public-rt-${var.tech_challenge_project_name}"
  }
}

# Associate route table
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_1" {
	subnet_id      = aws_subnet.public_subnet_1.id
	route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
	subnet_id      = aws_subnet.public_subnet_2.id
	route_table_id = aws_route_table.public.id
}