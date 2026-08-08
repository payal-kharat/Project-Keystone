resource "aws_cloudwatch_log_group" "this_ecs" {
  name              = "/ecs/${var.PROJECT_NAME}"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "this_task" {
  family       = var.TASK_FAMILY
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]

  cpu                = var.CPU
  memory             = var.MEMORY
  execution_role_arn = var.EXECUTION_ROLE_ARN
  task_role_arn      = var.TASK_ROLE_ARN
  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = "${var.FRONTEND_IMAGE}"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.this_ecs.name
          awslogs-region        = var.AWS_REGION
          awslogs-stream-prefix = "frontend"
        }
      }
    },

    {
      name      = "backend"
      image     = "${var.BACKEND_IMAGE}"
      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "DB_HOST"
          value = var.DB_HOST
        },
        {
          name  = "DB_NAME"
          value = var.DB_NAME
        },
        {
          name  = "DB_USER"
          value = var.DB_USER
        },
        {
          name  = "DB_PASSWORD"
          value = var.DB_PASSWORD
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.this_ecs.name
          awslogs-region        = var.AWS_REGION
          awslogs-stream-prefix = "backend"
        }
      }
    }
  ])

}