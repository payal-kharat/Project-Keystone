output "security_group_ids" {
  value = {
    for name, sg in aws_security_group.this_sg :
    name => sg.id
  }
}
output "alb_sg_id" {
  value = aws_security_group.this_sg["alb"].id
}
output "app_sg_id" {
  value = aws_security_group.this_sg["app"].id
}
output "db_sg_id" {
  value = aws_security_group.this_sg["db"].id
}
output "public_sg_id" {
  value = aws_security_group.this_sg["public"].id
}