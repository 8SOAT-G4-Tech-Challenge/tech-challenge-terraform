/* # Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.tech_challenge_project_name}"
  }
}

# Create subnet in the VPC 
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-${var.tech_challenge_project_name}"
  }
} */

# Create security group in the VPC
resource "aws_security_group" "vpc_link" {
  name        = "vpc-link-${var.tech_challenge_project_name}-sg"
  description = "Security group for VPC Link"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from API Gateway"
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
  }
}

# Create VPC Link
resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               	= "vpc-link-${var.tech_challenge_project_name}"
  security_group_ids 	= [aws_security_group.vpc_link.id]
  subnet_ids         = var.private_subnet_ids
}

# Create HTTP API Gateway
resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "api-${var.tech_challenge_project_name}"
  protocol_type = "HTTP"
	cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE"]
    allow_headers = ["*"]
  }
}

# Create API Gateway integration with ALB
resource "aws_apigatewayv2_integration" "alb_integration" {
  api_id           = aws_apigatewayv2_api.api_gateway.id
  integration_uri    = var.alb_dns_name
  integration_type = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.vpc_link.id

	request_parameters = {
    "overwrite:path" = "$request.path"
  }
}

# Create API Gateway route
resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}

# Create stage
resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}