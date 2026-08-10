output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
output "database_name" {
  value = module.rds.database_name
}
output "database_port" {
  value = module.rds.database_port
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
output "target_group_arn" {
  value = module.alb.target_group_arn
}
output "instance_id" {
  value = module.ec2.instance_id
}
output "private_ip" {
  value = module.ec2.private_ip
}

output "security_group_ids" {
  value = module.security_group.security_group_ids
}
output "alb_sg_id" {
  value = module.security_group.alb_sg_id
}
output "app_sg_id" {
  value = module.security_group.app_sg_id
}
output "db_sg_id" {
  value = module.security_group.db_sg_id
}
output "public_sg_id" {
  value = module.security_group.public_sg_id
}


