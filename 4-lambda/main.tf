resource "aws_lambda_function" "authenticate_admin" {
  function_name = "${var.project_name}-authenticate-admin"
  description   = "Authenticate Admin integrates with Cognito"
  s3_bucket     = "tech-challenge-bucket-lambdas"
  s3_key        = "authenticate-admin/authenticate-admin.zip"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = "arn:aws:iam::${var.aws_account_id}:role/LabRole"

  environment {
    variables = {
      Name = "${var.project_name}-authenticate-admin-lambda"
      Iac  = true
    }
  }
}


resource "aws_lambda_function" "authenticate_customer" {
  function_name = "${var.project_name}-authenticate-customer"
  description   = "Authenticate Customer and returns its data"
  s3_bucket     = "tech-challenge-bucket-lambdas"
  s3_key        = "authenticate-customer/authenticate-customer.zip"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = "arn:aws:iam::${var.aws_account_id}:role/LabRole"

  environment {
    variables = {
      Name = "${var.project_name}-authenticate-customer-lambda"
      Iac  = true
    }
  }
}
