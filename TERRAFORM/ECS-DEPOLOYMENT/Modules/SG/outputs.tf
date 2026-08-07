output "alb_sg_id" {

  value = aws_security_group.THIS_ALB.id

}

output "ecs_sg_id" {

  value = aws_security_group.THIS_ECS.id

}

output "rds_sg_id" {

  value = aws_security_group.THIS_RDS.id

}