output "user_pool_id" {
  value       = aws_cognito_user_pool.main.id
  description = "ID do Cognito User Pool"
}

output "user_pool_arn" {
  value       = aws_cognito_user_pool.main.arn
  description = "ARN do Cognito User Pool"
}

output "admin_client_id" {
  value       = aws_cognito_user_pool_client.admin.id
  description = "ID do client para administradores"
}

output "domain_name" {
  value       = aws_cognito_user_pool_domain.main.domain
  description = "Domínio do Cognito"
}