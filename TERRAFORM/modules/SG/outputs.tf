output "alb_sg_id" {
  value = aws_security_group.SG[0].id
}

output "app_sg_id" {
  value = aws_security_group.SG[1].id
}

output "db_sg_id" {
  value = aws_security_group.SG[2].id

}


output "public_sg_id" {
  value = aws_security_group.SG[3].id
}
