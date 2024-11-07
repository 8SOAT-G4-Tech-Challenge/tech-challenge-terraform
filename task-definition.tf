resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "webapp"
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::489134037384:role/ecsTaskExecutionRole"
  cpu = 1024
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }

  container_definitions = jsonencode([{
    name = "webapp-ctr"
    image = "strm/helloword-http"
    cpu = 1024
    memory = 256
    essencial = true
    portMapping = [{
        containerPort: 80
        hostPort = 80
        protocol = "tcp"
    }]
  }])
}