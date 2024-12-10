variable project_name {
	description = "The name of the project"
	type        = string
}
variable cognito_client_id {
	description = "The Cognito Client ID"
	type        = string
}
variable cognito_user_pool_id {
	description = "The Cognito User Pool ID"
	type        = string
}
variable region_default {
	description = "The default region"
	type        = string
}
variable aws_account_id {
	description = "The AWS Account ID"
	type        = string
}
variable authenticate_admin_lambda_name {
	description = "The name of the authenticate admin lambda"
	type        = string
}
variable "lb_listener_arn" {
	description = "The ARN of the LB listener"
	type = string
}


