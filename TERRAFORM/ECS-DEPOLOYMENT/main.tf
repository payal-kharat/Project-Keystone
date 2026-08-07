module "vpc" {
  source = "./Modules/VPC"
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_app_subnets = var.private_app_subnets
  private_db_subnets = var.private_db_subnets
  availability_zones = var.availability_zones
}

#SG

module "security_group" {
  source = "./Modules/SG"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  alb_ingress_port = var.alb_ingress_port
  alb_ingress_protocol = var.alb_ingress_protocol
  alb_ingress_cidr = var.alb_ingress_cidr
  ecs_port = var.ecs_port
  ecs_protocol = var.ecs_protocol
  db_port = var.db_port
  db_protocol = var.db_protocol
}

#ECR

module "ecr" {
  source = "./Modules/ECR"
  project_name = var.project_name
  frontend_repository_name = var.frontend_repository_name
  backend_repository_name = var.backend_repository_name
}

#ALB

module "alb" {
  source = "./Modules/ALB"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id = module.security_group.alb_sg_id
  alb_name = var.alb_name
  target_group_name = var.target_group_name
  listener_port = var.listener_port
  listener_protocol = var.listener_protocol
  target_group_port = var.target_group_port
  target_group_protocol = var.target_group_protocol
  health_check_path = var.health_check_path
}

#ECS CLuster

module "ecs_cluster" {
  source = "./Modules/ECS-Cluster"
  project_name = var.project_name
  cluster_name = var.cluster_name
}

# IAM

module "iam" {
  source = "./Modules/IAM"
  project_name = var.project_name
}

#RDS

module "rds" {
  source        = "./Modules/RDS"
  project_name  = var.project_name
  db_identifier = var.db_identifier
  db_name       = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_instance_class = var.db_instance_class
  allocated_storage = var.allocated_storage
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  rds_sg_id = module.security_group.rds_sg_id
}

#ECS_Defination
module "ecs_task" {
  source = "./Modules/ECS-Task"
  project_name = var.project_name
  task_family = var.task_family
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn = module.iam.task_role_arn
  frontend_image = var.frontend_image
  backend_image = var.backend_image
  aws_region = var.aws_region
  db_host = module.rds.db_address
  db_name = var.db_name
  db_user = var.db_username
  db_password = var.db_password
}

#ECS-Service

module "ecs_service" {
  source = "./Modules/ECS-Service"
  project_name = var.project_name
  service_name = var.service_name
  cluster_id = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_task.task_definition_arn
  desired_count = var.desired_count
  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  ecs_sg_id = module.security_group.ecs_sg_id
  target_group_arn = module.alb.target_group_arn
  frontend_container_name = var.frontend_container_name
  frontend_container_port = var.frontend_container_port
}