
# ALB Security Group

resource "aws_security_group" "THIS_ALB" {

  name   = "${var.project_name}-alb-sg"
  vpc_id = var.vpc_id

  ingress {

    from_port = var.alb_ingress_port
    to_port   = var.alb_ingress_port
    protocol  = var.alb_ingress_protocol

    cidr_blocks = var.alb_ingress_cidr

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "${var.project_name}-alb-sg"

  }

}

# ECS Security Group

resource "aws_security_group" "THIS_ECS" {

  name = "${var.project_name}-ecs-sg"

  vpc_id = var.vpc_id

  ingress {

    from_port = var.ecs_port
    to_port   = var.ecs_port

    protocol = var.ecs_protocol

    security_groups = [
      aws_security_group.THIS_ALB.id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "${var.project_name}-ecs-sg"

  }

}
# RDS Security Group

resource "aws_security_group" "THIS_RDS" {

  name = "${var.project_name}-rds-sg"


  vpc_id = var.vpc_id

  ingress {

    from_port = var.db_port
    to_port   = var.db_port

    protocol = var.db_protocol

    security_groups = [
      aws_security_group.THIS_ECS.id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "${var.project_name}-rds-sg"

  }

}