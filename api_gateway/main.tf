# Create VPC Link
resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "${var.project_name}-vpc-link"
  security_group_ids = [data.aws_security_group.tc_security_group.id]
  subnet_ids         = [data.aws_subnet.subnet_private_1.id, data.aws_subnet.subnet_private_2.id]
}

# Create HTTP API Gateway
resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "${var.project_name}-api-gateway"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE"]
    allow_headers = ["*"]
  }
}

# JWT Authorizer using Cognito
resource "aws_apigatewayv2_authorizer" "cognito" {
  api_id           = aws_apigatewayv2_api.api_gateway.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = [var.cognito_client_id]
    issuer   = "https://cognito-idp.${var.region_default}.amazonaws.com/${var.cognito_user_pool_id}"
  }
}

# Auth route for login
resource "aws_apigatewayv2_route" "auth" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "POST /auth"
  target    = "integrations/${aws_apigatewayv2_integration.auth.id}"
}

# Integration with Cognito for authentication
resource "aws_apigatewayv2_integration" "auth" {
  api_id                 = aws_apigatewayv2_api.api_gateway.id
  integration_type       = "AWS_PROXY"
  integration_uri        = "arn:aws:lambda:us-east-1:${var.aws_account_id}:function:${var.aws_lambda_function_name_admin}"
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.aws_lambda_function_name_admin
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}

# Create API Gateway integration with NLB
resource "aws_apigatewayv2_integration" "nlb_integration" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  integration_uri    = var.lb_listener_arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.vpc_link.id

  request_parameters = {
    "overwrite:path" = "$request.path"
  }
}

# Create API Gateway route
resource "aws_apigatewayv2_route" "route_admin" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  route_key          = "ANY /admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.cognito.id
}

# Create API Gateway route
resource "aws_apigatewayv2_route" "route_totem" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /totem/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
}

# Create stage
resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}