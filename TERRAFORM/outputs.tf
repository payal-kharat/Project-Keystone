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
