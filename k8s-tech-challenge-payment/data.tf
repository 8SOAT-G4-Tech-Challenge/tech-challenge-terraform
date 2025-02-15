data "aws_secretsmanager_secret" "database_secret" {
  name = "tech-challenge-payment-atlas-mongodb-endpoint"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.database_secret.id
}