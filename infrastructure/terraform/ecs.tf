resource "aws_ecs_cluster" "cbc_cluster" {
  name = "${var.prefix}-cluster"
}

# Log group para ECS
resource "aws_cloudwatch_log_group" "cbc" {
  name              = "/ecs/${var.prefix}"
  retention_in_days = 7
}

# Definición de la tarea ECS
resource "aws_ecs_task_definition" "cbc_task" {
  family                   = "${var.prefix}-task"
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn # Rol para que ECS baje la imagen
  task_role_arn            = aws_iam_role.ecs_task_role.arn # Rol para usar S3

  container_definitions = jsonencode([{
    name      = "${var.prefix}-container"
    image     = "${aws_ecr_repository.cbc_data_pipeline.repository_url}:latest"
    cpu       = var.ecs_cpu
    memory    = var.ecs_memory
    essential = true

    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.cbc.name
        awslogs-region        = var.region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

# Servicio ECS usando solo subred pblica
resource "aws_ecs_service" "cbc_service" {
  name            = "${var.prefix}-service"
  cluster         = aws_ecs_cluster.cbc_cluster.id
  task_definition = aws_ecs_task_definition.cbc_task.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-0eaffef0f194c1de9"] # Subred pública
    security_groups  = var.ecs_security_groups
    assign_public_ip = true
  }

  depends_on = [
    aws_iam_role.ecs_task_execution_role,
    aws_iam_policy_attachment.ecs_task_execution_policy,
    aws_iam_role.ecs_task_role
  ]
}
