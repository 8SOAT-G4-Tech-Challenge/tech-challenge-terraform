variable "project_name" {
  description = "The name of the project"
  type        = string
}
variable "cognito_client_id" {
  description = "The Cognito Client ID"
  type        = string
}
variable "cognito_user_pool_id" {
  description = "The Cognito User Pool ID"
  type        = string
}
variable "region_default" {
  description = "The default region"
  type        = string
}
variable "aws_account_id" {
  description = "The AWS Account ID"
  type        = string
}
variable "lb_listener_arn" {
  description = "The ARN of the LB listener"
  type        = string
}
variable "aws_lambda_function_name_admin" {
  description = "tech-challenge-authenticate-admin"
}
variable "aws_lambda_function_name_customer" {
  description = "tech-challenge-authenticate-customer"
}