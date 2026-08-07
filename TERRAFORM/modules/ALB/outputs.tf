output "alb_arn" {
  value = aws_lb.this_alb.arn
}

output "alb_dns_name" {
  value = aws_lb.this_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this_tg.arn
}

output "target_group_name" {
  value = aws_lb_target_group.this_tg.name
}
