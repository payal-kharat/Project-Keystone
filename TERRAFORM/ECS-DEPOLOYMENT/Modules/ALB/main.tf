
# Application Load Balancer


resource "aws_lb" "THIS_ALB" {

  name = var.alb_name

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.alb_sg_id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {

    Name = var.alb_name

  }

}


# Target Group


resource "aws_lb_target_group" "THIS_TG" {

  name = var.target_group_name

  port = var.target_group_port

  protocol = var.target_group_protocol

  target_type = "ip"

  vpc_id = var.vpc_id

  health_check {

    enabled = true

    path = var.health_check_path

    protocol = var.target_group_protocol

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2

  }

  tags = {

    Name = var.target_group_name

  }

}


# Listener


resource "aws_lb_listener" "THIS_LISTNERS" {

  load_balancer_arn = aws_lb.THIS_ALB.arn

  port = var.listener_port

  protocol = var.listener_protocol

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.THIS_TG.arn

  }

}