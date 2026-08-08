
# ECS Task Execution Role
resource "aws_iam_role" "this_ecs_execution_role" {
  name = "${var.PROJECT_NAME}-ecs-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "${var.PROJECT_NAME}-ecs-execution-role"
  }
}

# ECS Task Role


resource "aws_iam_role" "this_ecs_task_role" {
  name = "${var.PROJECT_NAME}-ecs-task-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "${var.PROJECT_NAME}-ecs-task-role"
  }
}


# Attach ECS Execution Policy


resource "aws_iam_role_policy_attachment" "this_execution_policy" {
  role       = aws_iam_role.this_ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# CloudWatch Logs Policy


resource "aws_iam_role_policy_attachment" "this_cloudwatch_logs" {
  role       = aws_iam_role.this_ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}