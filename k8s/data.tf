data "aws_db_instance" "rds_database_url" {
  db_instance_identifier = "tech-challenge-database"
}

data "aws_secretsmanager_secret" "database_secret" {
  name = "aws_rds_endpoint"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.database_secret.id
}

data "aws_elasticache_cluster" "redis_cluster" {
  cluster_id = "tech-challenge-redis"
}
