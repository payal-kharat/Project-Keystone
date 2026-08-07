output "alb_sg_id" {
  value = aws_security_group.this_sg[0].id
}

output "app_sg_id" {
  value = aws_security_group.this_sg[1].id
}

output "db_sg_id" {
  value = aws_security_group.this_sg[2].id
}

output "public_sg_id" {
  value = aws_security_group.this_sg[3].id
}
