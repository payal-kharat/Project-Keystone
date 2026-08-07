output "alb_arn" {

  value = aws_lb.THIS_ALB.arn

}

output "alb_dns_name" {

  value = aws_lb.THIS_ALB.dns_name

}

output "alb_zone_id" {

  value = aws_lb.THIS_ALB.zone_id

}

output "target_group_arn" {

  value = aws_lb_target_group.THIS_TG.arn

}

output "listener_arn" {

  value = aws_lb_listener.THIS_LISTNERS.arn

}