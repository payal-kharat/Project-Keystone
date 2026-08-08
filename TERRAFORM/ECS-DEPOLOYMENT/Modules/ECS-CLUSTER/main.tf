
resource "aws_ecs_cluster" "this_cluster" {
  name = var.CLUSTER_NAME
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name    = var.CLUSTER_NAME
    Project = var.PROJECT_NAME
  }
}