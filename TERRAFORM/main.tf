module "vpc" {
  source                   = "./modules/VPC"
  VPC_CIDR                 = var.MOD_VPC_CIDR
  VPC_NAME                 = var.MOD_VPC_NAME
  IGW_NAME                 = var.MOD_IGW_NAME
  PUBLIC_SUBNET_COUNT      = var.MOD_PUBLIC_SUBNET_COUNT
  PRIVATE_APP_SUBNET_COUNT = var.MOD_PRIVATE_APP_SUBNET_COUNT
  PRIVATE_DB_SUBNET_COUNT  = var.MOD_PRIVATE_DB_SUBNET_COUNT
  NAT_EIP_NAME             = var.MOD_NAT_EIP_NAME
  NAT_GW_NAME              = var.MOD_NAT_GW_NAME
  PUBLIC_ROUTE_CIDR        = var.MOD_PUBLIC_ROUTE_CIDR
  PUBLIC_RT_NAME           = var.MOD_PUBLIC_RT_NAME
  PRIVATE_ROUTE_CIDR       = var.MOD_PRIVATE_ROUTE_CIDR
  PRIVATE_RT_NAME          = var.MOD_PRIVATE_RT_NAME
  PUBLIC_SUBNET_CIDRS      = var.MOD_PUBLIC_SUBNET_CIDRS
  PRIVATE_APP_SUBNET_CIDRS = var.MOD_PRIVATE_APP_SUBNET_CIDRS
  PRIVATE_DB_SUBNET_CIDRS  = var.MOD_PRIVATE_DB_SUBNET_CIDRS
  AVAILABILITY_ZONES       = var.MOD_AVAILABILITY_ZONES
}

module "security_group" {
  source                 = "./modules/SG"
  VPC_ID                 = module.vpc.vpc_id
  SECURITY_GROUPS        = var.MOD_SECURITY_GROUPS
}


module "rds" {
  source               = "./modules/RDS"
  DB_NAME              = var.MOD_DB_NAME
  DB_SUBNET_GROUP_NAME = var.MOD_DB_SUBNET_GROUP_NAME
  DB_INSTANCE_NAME     = var.MOD_DB_INSTANCE_NAME
  DB_USERNAME          = var.MOD_DB_USERNAME
  DB_PASSWORD          = var.MOD_DB_PASSWORD
  DB_ENGINE            = var.MOD_DB_ENGINE
  DB_ENGINE_VERSION    = var.MOD_DB_ENGINE_VERSION
  DB_INSTANCE_CLASS    = var.MOD_DB_INSTANCE_CLASS
  ALLOCATED_STORAGE    = var.MOD_ALLOCATED_STORAGE
  DB_STORAGE_TYPE      = var.MOD_DB_STORAGE_TYPE
  SUBNET_IDS           = module.vpc.private_db_subnet_ids
  SECURITY_GROUP_ID    = module.security_group.db_sg_id
}

module "alb" {
  source                     = "./modules/ALB"
  ALB_NAME                   = var.MOD_ALB_NAME
  LB_TYPE                    = var.MOD_LB_TYPE
  ALB_TARGATE_TYPE           = var.MOD_ALB_TARGATE_TYPE
  TARGATE_GROUP_NAME         = var.MOD_TARGATE_GROUP_NAME
  ALB_TARGATE_GROUP_PROTOCOL = var.MOD_ALB_TARGATE_GROUP_PROTOCOL
  ALB_TARGATE_PORT           = var.MOD_ALB_TARGATE_PORT
  ALB_LISTNER_PROTOCOL       = var.MOD_ALB_LISTNER_PROTOCOL
  ALB_LISTNER_PORT           = var.MOD_ALB_LISTNER_PORT
  VPC_ID                     = module.vpc.vpc_id
  SUBNET_IDS                 = module.vpc.public_subnet_ids
  SECURITY_GROUP_ID          = module.security_group.alb_sg_id
}

module "ec2" {
  source                  = "./modules/EC2_Instance"
  AMI_ID                  = var.MOD_AMI_ID
  INSTANCE_TYPE           = var.MOD_INSTANCE_TYPE
  KEY_NAME                = module.key_pair.key_name
  ASSOCIATE_PUBLIC_IP     = false
  INSTANCE_NAME           = "APPLICATION HOST"
  SUBNET_ID               = module.vpc.private_app_subnet_ids[0]
  SECURITY_GROUP_ID       = module.security_group.app_sg_id
  ATTACH_TO_TARGATE_GROUP = true
  TARGATE_GROUP_ARN       = module.alb.target_group_arn
}

module "bastion_ec2" {
  source                  = "./modules/EC2_Instance"
  AMI_ID                  = var.MOD_AMI_ID
  INSTANCE_TYPE           = var.MOD_INSTANCE_TYPE
  KEY_NAME                = module.key_pair.key_name
  SUBNET_ID               = module.vpc.public_subnet_ids[0]
  SECURITY_GROUP_ID       = module.security_group.public_sg_id
  ASSOCIATE_PUBLIC_IP     = true
  INSTANCE_NAME           = "Public-Host"
  ATTACH_TO_TARGATE_GROUP = false
  TARGATE_GROUP_ARN       = null
}

module "key_pair" {
  source   = "./modules/Key_Pair"
  KEY_NAME = var.MOD_KEY_NAME
}



