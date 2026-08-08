
# ALB Security Group

resource "aws_security_group" "this_alb" {
  name   = "${var.PROJECT_NAME}-alb-sg"
  vpc_id = var.VPC_ID
  ingress {
    from_port   = var.ALB_INGRESS_PORT
    to_port     = var.ALB_INGRESS_PORT
    protocol    = var.ALB_INGRESS_PROTOCOL
    cidr_blocks = var.ALB_INGRESS_CIDR
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.PROJECT_NAME}-alb-sg"
  }
}

# ECS SG

resource "aws_security_group" "this_ecs" {
  name   = "${var.PROJECT_NAME}-ecs-sg"
  vpc_id = var.VPC_ID
  ingress {
    from_port = var.ECS_PORT
    to_port   = var.ECS_PORT
    protocol  = var.ECS_PROTOCOL
    security_groups = [
      aws_security_group.this_alb.id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.PROJECT_NAME}-ecs-sg"
  }
}

# RDS SG

resource "aws_security_group" "this_rds" {
  name   = "${var.PROJECT_NAME}-rds-sg"
  vpc_id = var.VPC_ID
  ingress {
    from_port = var.DB_PORT
    to_port   = var.DB_PORT
    protocol  = var.DB_PROTOCOL
    security_groups = [
      aws_security_group.this_ecs.id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.PROJECT_NAME}-rds-sg"
  }
}
