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

# Create integration with Lambda for customer auth
resource "aws_apigatewayv2_integration" "customer" {
  api_id                 = aws_apigatewayv2_api.api_gateway.id
  integration_type       = "AWS_PROXY"
  integration_uri        = "arn:aws:lambda:us-east-1:${var.aws_account_id}:function:${var.aws_lambda_function_customer_name}"
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Customer auth route for login
resource "aws_apigatewayv2_route" "customer" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "POST /customer"
  target    = "integrations/${aws_apigatewayv2_integration.customer.id}"

  depends_on = [aws_apigatewayv2_integration.customer]
}

# Permission to run customer lambda
resource "aws_lambda_permission" "apigw_lambda_customer" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.aws_lambda_function_customer_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}

# Integration with Cognito for authentication
resource "aws_apigatewayv2_integration" "auth" {
  api_id                 = aws_apigatewayv2_api.api_gateway.id
  integration_type       = "AWS_PROXY"
  integration_uri        = "arn:aws:lambda:us-east-1:${var.aws_account_id}:function:${var.aws_lambda_function_admin_name}"
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Auth route for login
resource "aws_apigatewayv2_route" "auth" {
  api_id     = aws_apigatewayv2_api.api_gateway.id
  route_key  = "POST /auth"
  target     = "integrations/${aws_apigatewayv2_integration.auth.id}"
  depends_on = [aws_apigatewayv2_integration.auth]
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.aws_lambda_function_admin_name
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

# Create API Gateway route admin
resource "aws_apigatewayv2_route" "route_order_admin" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  route_key          = "ANY /orders/admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.cognito.id
  depends_on         = [aws_apigatewayv2_integration.nlb_integration]
}

resource "aws_apigatewayv2_route" "route_payment_admin" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  route_key          = "ANY /payments/admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.cognito.id
  depends_on         = [aws_apigatewayv2_integration.nlb_integration]
}

resource "aws_apigatewayv2_route" "route_user_admin" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  route_key          = "ANY /users/admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.cognito.id
  depends_on         = [aws_apigatewayv2_integration.nlb_integration]
}

# Create API Gateway route totem
resource "aws_apigatewayv2_route" "route_order_totem" {
  api_id     = aws_apigatewayv2_api.api_gateway.id
  route_key  = "ANY /orders/totem/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  depends_on = [aws_apigatewayv2_integration.nlb_integration]
}

resource "aws_apigatewayv2_route" "route_payment_totem" {
  api_id     = aws_apigatewayv2_api.api_gateway.id
  route_key  = "ANY /payments/totem/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  depends_on = [aws_apigatewayv2_integration.nlb_integration]
}

resource "aws_apigatewayv2_route" "route_user_totem" {
  api_id     = aws_apigatewayv2_api.api_gateway.id
  route_key  = "ANY /users/totem/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  depends_on = [aws_apigatewayv2_integration.nlb_integration]
}

# Create API Gateway route health
resource "aws_apigatewayv2_route" "route_order_health" {
  api_id     = aws_apigatewayv2_api.api_gateway.id
  route_key  = "ANY /orders/health"
  target     = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  depends_on = [aws_apigatewayv2_integration.nlb_integration]
}

resource "aws_apigatewayv2_route" "route_payment_health" {
  api_id     = aws_apigatewayv2_api.api_gateway.id
  route_key  = "ANY /payments/health"
  target     = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  depends_on = [aws_apigatewayv2_integration.nlb_integration]
}

resource "aws_apigatewayv2_route" "route_user_health" {
  api_id     = aws_apigatewayv2_api.api_gateway.id
  route_key  = "ANY /users/health"
  target     = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
  depends_on = [aws_apigatewayv2_integration.nlb_integration]
}

# Create stage
resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}
