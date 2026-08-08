resource "aws_ecs_service" "this_ecs_service" {
  name                               = var.SERVICE_NAME
  cluster                            = var.CLUSTER_ID
  task_definition                    = var.TASK_DEFINITION_ARN
  desired_count                      = var.DESIRED_COUNT
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  enable_execute_command             = true
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets = var.PRIVATE_APP_SUBNET_IDS
    security_groups = [
      var.ECS_SG_ID
    ]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.TARGET_GROUP_ARN
    container_name   = var.FRONTEND_CONTAINER_NAME
    container_port   = var.FRONTEND_CONTAINER_PORT
  }
  depends_on = [
    var.TARGET_GROUP_ARN
  ]
}