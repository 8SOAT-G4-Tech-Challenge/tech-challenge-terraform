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
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = data.aws_vpc.vpc.id
  cidr_block        = "172.31.112.0/20"
  availability_zone = "${var.region_default}b"

  tags = {
    Name = "private-subnet-2-${var.tech_challenge_project_name}"
  }
}

# Create NAT Gateway (requires public subnet and EIP)
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = data.aws_subnets.subnets.ids[0]

  tags = {
    Name = "nat-gateway-${var.tech_challenge_project_name}"
  }
}

# Create route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt-${var.tech_challenge_project_name}"
  }
}

# Associate route table with private subnets
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}