
resource "aws_lb" "this_alb" {
  name               = var.ALB_NAME
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    var.ALB_SG_ID
  ]
  subnets                    = var.PUBLIC_SUBNET_IDS
  enable_deletion_protection = false
  tags = {
    Name = var.ALB_NAME
  }
}

# Target Group

resource "aws_lb_target_group" "this_tg" {
  name        = var.TARGET_GROUP_NAME
  port        = var.TARGET_GROUP_PORT
  protocol    = var.TARGET_GROUP_PROTOCOL
  target_type = "ip"
  vpc_id      = var.VPC_ID
  health_check {
    enabled             = true
    path                = var.HEALTH_CHECK_PATH
    protocol            = var.TARGET_GROUP_PROTOCOL
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = var.TARGET_GROUP_NAME
  }
}


# Listener


resource "aws_lb_listener" "this_listners" {
  load_balancer_arn = aws_lb.this_alb.arn
  port              = var.LISTENER_PORT
  protocol          = var.LISTENER_PROTOCOL
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this_tg.arn
  }
}