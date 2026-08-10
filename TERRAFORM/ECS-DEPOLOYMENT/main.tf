module "vpc" {
  source              = "./Modules/VPC"
  PROJECT_NAME        = var.PROJECT_NAME
  VPC_CIDR            = var.VPC_CIDR
  PUBLIC_SUBNETS      = var.PUBLIC_SUBNETS
  PRIVATE_APP_SUBNETS = var.PRIVATE_APP_SUBNETS
  PRIVATE_DB_SUBNETS  = var.PRIVATE_DB_SUBNETS
  AVAILABILITY_ZONES  = var.AVAILABILITY_ZONES
}

module "security_group" {
  source               = "./Modules/SG"
  PROJECT_NAME         = var.PROJECT_NAME
  VPC_ID               = module.vpc.vpc_id
  ALB_INGRESS_PORT     = var.ALB_INGRESS_PORT
  ALB_INGRESS_PROTOCOL = var.ALB_INGRESS_PROTOCOL
  ALB_INGRESS_CIDR     = var.ALB_INGRESS_CIDR
  ECS_PORT             = var.ECS_PORT
  ECS_PROTOCOL         = var.ECS_PROTOCOL
  DB_PORT              = var.DB_PORT
  DB_PROTOCOL          = var.DB_PROTOCOL
}

module "ecr" {
  source                   = "./Modules/ECR"
  PROJECT_NAME             = var.PROJECT_NAME
  FRONTEND_REPOSITORY_NAME = var.FRONTEND_REPOSITORY_NAME
  BACKEND_REPOSITORY_NAME  = var.BACKEND_REPOSITORY_NAME
}

module "alb" {
  source                = "./Modules/ALB"
  PROJECT_NAME          = var.PROJECT_NAME
  VPC_ID                = module.vpc.vpc_id
  PUBLIC_SUBNET_IDS     = module.vpc.public_subnet_ids
  ALB_SG_ID             = module.security_group.alb_sg_id
  ALB_NAME              = var.ALB_NAME
  TARGET_GROUP_NAME     = var.TARGET_GROUP_NAME
  LISTENER_PORT         = var.LISTENER_PORT
  LISTENER_PROTOCOL     = var.LISTENER_PROTOCOL
  TARGET_GROUP_PORT     = var.TARGET_GROUP_PORT
  TARGET_GROUP_PROTOCOL = var.TARGET_GROUP_PROTOCOL
  HEALTH_CHECK_PATH     = var.HEALTH_CHECK_PATH
}

module "ecs_cluster" {
  source       = "./Modules/ECS-Cluster"
  PROJECT_NAME = var.PROJECT_NAME
  CLUSTER_NAME = var.CLUSTER_NAME
}

module "iam" {
  source       = "./Modules/IAM"
  PROJECT_NAME = var.PROJECT_NAME
}

module "rds" {
  source                = "./Modules/RDS"
  PROJECT_NAME          = var.PROJECT_NAME
  DB_IDENTIFIER         = var.DB_IDENTIFIER
  DB_NAME               = var.DB_NAME
  DB_USERNAME           = var.DB_USERNAME
  DB_PASSWORD           = var.DB_PASSWORD
  DB_INSTANCE_CLASS     = var.DB_INSTANCE_CLASS
  ALLOCATED_STORAGE     = var.ALLOCATED_STORAGE
  PRIVATE_DB_SUBNET_IDS = module.vpc.private_db_subnet_ids
  RDS_SG_ID             = module.security_group.rds_sg_id
}

module "ecs_task" {
  source             = "./Modules/ECS-Task"
  PROJECT_NAME       = var.PROJECT_NAME
  TASK_FAMILY        = var.TASK_FAMILY
  CPU                = var.CPU
  MEMORY             = var.MEMORY
  EXECUTION_ROLE_ARN = module.iam.execution_role_arn
  TASK_ROLE_ARN      = module.iam.task_role_arn
  FRONTEND_IMAGE     = var.FRONTEND_IMAGE
  BACKEND_IMAGE      = var.BACKEND_IMAGE
  AWS_REGION         = var.AWS_REGION
  DB_HOST            = module.rds.db_address
  DB_NAME            = var.DB_NAME
  DB_USER            = var.DB_USERNAME
  DB_PASSWORD        = var.DB_PASSWORD
}

module "ecs_service" {
  source                  = "./Modules/ECS-Service"
  PROJECT_NAME            = var.PROJECT_NAME
  SERVICE_NAME            = var.SERVICE_NAME
  CLUSTER_ID              = module.ecs_cluster.cluster_id
  TASK_DEFINITION_ARN     = module.ecs_task.task_definition_arn
  DESIRED_COUNT           = var.DESIRED_COUNT
  PRIVATE_APP_SUBNET_IDS  = module.vpc.private_app_subnet_ids
  ECS_SG_ID               = module.security_group.ecs_sg_id
  TARGET_GROUP_ARN        = module.alb.target_group_arn
  FRONTEND_CONTAINER_NAME = var.FRONTEND_CONTAINER_NAME
  FRONTEND_CONTAINER_PORT = var.FRONTEND_CONTAINER_PORT
}
