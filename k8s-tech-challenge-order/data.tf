data "aws_db_instance" "rds_database_url" {
  db_instance_identifier = "tech-challenge-order-database" // Está sendo usado?
}

data "aws_secretsmanager_secret" "database_secret" {
  name = "tech-challenge-order-aws-rds-endpoint"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.database_secret.id
}
