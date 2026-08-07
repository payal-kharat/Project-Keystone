resource "aws_lb" "this_alb" {
  name               = var.ALB_NAME
  internal           = false
  load_balancer_type = var.LB_TYPE
  security_groups = [
    var.SECURITY_GROUP_ID
  ]
  subnets                    = var.SUBNET_IDS
  enable_deletion_protection = false
  tags = {
    Name = var.ALB_NAME
  }
}

resource "aws_lb_target_group" "this_tg" {
  name        = var.TARGATE_GROUP_NAME
  port        = var.ALB_TARGATE_PORT
  protocol    = var.ALB_TARGATE_GROUP_PROTOCOL
  target_type = var.ALB_TARGATE_TYPE
  vpc_id      = var.VPC_ID
  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  tags = {
    Name = var.TARGATE_GROUP_NAME
  }
}

resource "aws_lb_listener" "this_http" {
  load_balancer_arn = aws_lb.this_alb.arn
  port              = var.ALB_LISTNER_PORT
  protocol          = var.ALB_LISTNER_PROTOCOL
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this_tg.arn
  }
}
