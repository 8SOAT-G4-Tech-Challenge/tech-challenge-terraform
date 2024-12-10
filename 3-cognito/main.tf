resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}-user-pool"

  mfa_configuration = "OFF"
  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = false
  }

  schema {
    attribute_data_type = "String"
    name                = "custom:cpf"
    required            = false
    mutable             = true
  }

	username_attributes = ["email"]
  auto_verified_attributes = ["email"]

  tags = {
    Name        = "${var.project_name}-user-pool"
    Iac				 = true
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${var.project_name}-domain"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_pool_client" "admin" {
  name         = "admin-client"
  user_pool_id = aws_cognito_user_pool.main.id
	callback_urls                        = ["https://example.com"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "aws.cognito.signin.user.admin"]
  supported_identity_providers         = ["COGNITO"]

  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  generate_secret = false
}

resource "aws_cognito_user" "admin" {
  user_pool_id = aws_cognito_user_pool.main.id
  username     = var.admin_user_email

  attributes = {
    email = var.admin_user_email
		email_verified = true
  }

  password = var.admin_user_password
  depends_on = [aws_cognito_user_pool.main]
}

resource "aws_cognito_user_group" "admin" {
  user_pool_id = aws_cognito_user_pool.main.id
  name         = "admin"
  description  = "Administrators group"
}

resource "aws_cognito_user_in_group" "admin" {
  user_pool_id = aws_cognito_user_pool.main.id
  username     = aws_cognito_user.admin.username
  group_name   = aws_cognito_user_group.admin.name
}

# Create SSM parameter for Cognito Client ID
resource "aws_ssm_parameter" "cognito_client_id" {
  name  = "/tech-challenge/cognito/client-id"
  type  = "String"
  value = aws_cognito_user_pool_client.admin.id
}