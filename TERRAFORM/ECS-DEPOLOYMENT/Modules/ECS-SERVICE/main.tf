resource "aws_ecs_service" "this" {
  name = var.service_name
  cluster = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count = var.desired_count
  launch_type = "FARGATE"
  platform_version = "LATEST"
  enable_execute_command = true
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200

  network_configuration {
    subnets = var.private_app_subnet_ids
    security_groups = [
      var.ecs_sg_id
    ]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = var.frontend_container_name
    container_port = var.frontend_container_port
  }
  depends_on = [
    var.target_group_arn
  ]
}