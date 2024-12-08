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
  integration_uri    = var.nlb_listener_arn
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