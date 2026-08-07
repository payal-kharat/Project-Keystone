
resource "aws_ecs_cluster" "THIS_CLUSTER" {
  name = var.cluster_name
  setting {
    name = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.cluster_name
    Project = var.project_name
  }
}