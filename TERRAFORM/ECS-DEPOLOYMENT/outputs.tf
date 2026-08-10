output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

#SG
output "security_group_ids" {
  value = module.security_group.security_group_ids
}
output "alb_sg_id" {
  value = module.security_group.alb_sg_id
}
output "ecs_sg_id" {
  value = module.security_group.ecs_sg_id
}
output "rds_sg_id" {
  value = module.security_group.rds_sg_id
}

#ECR
output "frontend_repository_url" {
  value = module.ecr.frontend_repository_url
}

output "backend_repository_url" {
  value = module.ecr.backend_repository_url
}

#ALB

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "listener_arn" {
  value = module.alb.listener_arn
}
#ECS Cluster

output "cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "cluster_arn" {
  value = module.ecs_cluster.cluster_arn
}

#IAM

output "execution_role_arn" {
  value = module.iam.execution_role_arn
}

output "task_role_arn" {
  value = module.iam.task_role_arn
}

#RDS

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_address" {
  value = module.rds.db_address
}

output "db_name" {
  value = module.rds.db_name
}

# ECS-Task

output "task_definition_arn" {
  value = module.ecs_task.task_definition_arn
}

output "task_definition_family" {
  value = module.ecs_task.task_definition_family
}

output "task_definition_revision" {
  value = module.ecs_task.task_definition_revision
}
#ECS-Service

output "ecs_service_name" {
  value = module.ecs_service.service_name
}

output "ecs_service_arn" {
  value = module.ecs_service.service_arn
}
