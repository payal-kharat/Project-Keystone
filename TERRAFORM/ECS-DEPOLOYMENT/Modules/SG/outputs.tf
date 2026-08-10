output "security_group_ids" {

  value = {
    for name, sg in aws_security_group.this_sg :
    name => sg.id
  }
}

output "alb_sg_id" {
  value = aws_security_group.this_sg["alb"].id
}

output "ecs_sg_id" {
  value = aws_security_group.this_sg["ecs"].id
}

output "rds_sg_id" {
  value = aws_security_group.this_sg["rds"].id
}