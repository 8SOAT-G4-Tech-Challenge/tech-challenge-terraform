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

/* data "kubernetes_service" "nlb_service" {
  metadata {
    name = "api-tech-challenge-service"
    namespace = "default"
  }
  depends_on = [kubernetes_service.api_tech_challenge_service]
} */

data "aws_lb" "nlb" {
  tags = {
    "kubernetes.io/service-name" = "default/api-tech-challenge-service"
  }
	depends_on = [kubernetes_service.api_tech_challenge_service]
}

data "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = data.aws_lb.nlb.arn
  port              = 80
}