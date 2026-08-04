resource "aws_lb" "alb" {
  name = var.alb_name
  internal = false
  load_balancer_type = var.lb_type
  security_groups = [
    var.security_group_id
  ]
  subnets = var.subnet_ids
  enable_deletion_protection = false
  tags = {
    Name = var.alb_name
  }
}


resource "aws_lb_target_group" "tg" {
  name = var.target_group_name
  port = var.alb_targate_port
  protocol = var.alb_targate_group_protocol
  target_type = var.alb_targate_type
  vpc_id = var.vpc_id
  health_check {
    enabled = true
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
  tags = {
    Name = var.target_group_name
  }
}



resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = var.alb_listner_port
  protocol = var.alb_listner_protocol
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

}
