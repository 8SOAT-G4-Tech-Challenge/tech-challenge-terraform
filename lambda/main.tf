resource "aws_lambda_function" "authenticate_admin" {
  function_name    = "${var.project_name}-authenticate-admin"
	description			= "Authenticate Admin integrates with Cognito"
  s3_bucket       = "tech-challenge-bucket-lambdas"
  s3_key          = "authenticate-admin.zip"
  handler         = "index.handler"
  runtime         = "nodejs18.x"
  role           = "arn:aws:iam::${var.aws_account_id}:role/LabRole"

  environment {
    variables = {
			Name = "${var.project_name}-authenticate-admin-lambda"
      Iac = true
    }
  }
}