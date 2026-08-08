output "alb_sg_id" {
  value = aws_security_group.this_alb.id
}

output "ecs_sg_id" {
  value = aws_security_group.this_ecs.id
}

output "rds_sg_id" {
  value = aws_security_group.this_rds.id
}