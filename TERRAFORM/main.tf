# VPC

module "vpc" {
  source                   = "./modules/vpc"
  vpc_cidr                 = var.mod_vpc_cidr
  vpc_name                 = var.mod_vpc_name
  igw_name                 = var.mod_igw_name
  public_subnet_count      = var.mod_public_subnet_count
  private_app_subnet_count = var.mod_private_app_subnet_count
  private_db_subnet_count  = var.mod_private_db_subnet_count
  nat_eip_name             = var.mod_nat_eip_name
  nat_gw_name              = var.mod_nat_gw_name
  public_route_cidr        = var.mod_public_route_cidr
  public_RT_name           = var.mod_public_RT_name
  private_route_cidr       = var.mod_private_route_cidr
  private_RT_name          = var.mod_private_RT_name
  public_subnet_cidrs      = var.mod_public_subnet_cidrs
  private_app_subnet_cidrs = var.mod_private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.mod_private_db_subnet_cidrs
  availability_zones       = var.mod_availability_zones
}

#SG

module "security_group" {

  source               = "./modules/SG"
  vpc_id               = module.vpc.vpc_id
  security_group_names = var.mod_security_group_names
  SG_protocol          = var.mod_SG_protocol
  SG_cidr_blocks       = var.mod_SG_cidr_blocks
  egress_protocol      = var.mod_egress_protocol
  alb_ports            = var.mod_alb_ports
  app_ports            = var.mod_app_ports
  db_ports             = var.mod_db_ports
  public_ports         = var.mod_public_ports

}


# RDS

module "rds" {
  source               = "./modules/RDS"
  db_name              = var.mod_db_name
  db_subnet_group_name = var.mod_db_subnet_group_name
  db_instance_name     = var.mod_db_instance_name
  db_username          = var.mod_db_username
  db_password          = var.mod_db_password
  db_engine            = var.mod_db_engine
  db_engine_version    = var.mod_db_engine_version
  db_instance_class    = var.mod_db_instance_class
  allocated_storage    = var.mod_allocated_storage
  db_storage_type      = var.mod_db_storage_type
  subnet_ids           = module.vpc.private_db_subnet_ids
  security_group_id    = module.security_group.db_sg_id

}

# ALB

module "alb" {
  source                     = "./modules/ALB"
  alb_name                   = var.mod_alb_name
  lb_type                    = var.mod_lb_type
  alb_targate_type           = var.mod_alb_targate_type
  target_group_name          = var.mod_target_group_name
  alb_targate_group_protocol = var.mod_alb_targate_group_protocol
  alb_targate_port           = var.mod_alb_targate_port
  alb_listner_protocol       = var.mod_alb_listner_protocol
  alb_listner_port           = var.mod_alb_listner_port
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.public_subnet_ids
  security_group_id          = module.security_group.alb_sg_id

}

# EC2_Instances

module "ec2" {
  source                 = "./modules/EC2_Instance"
  ami_id                 = var.mod_ami_id
  instance_type          = var.mod_instance_type
  key_name               = module.key_pair.key_name
  associate_public_ip    = false
  instance_name          = "application_Host"
  subnet_id              = module.vpc.private_app_subnet_ids[0]
  security_group_id      = module.security_group.app_sg_id
  attach_to_target_group = true
  target_group_arn       = module.alb.target_group_arn
}


module "public_ec2" {
  source                 = "./modules/EC2_Instance"
  ami_id                 = var.mod_ami_id
  instance_type          = var.mod_instance_type
  key_name               = module.key_pair.key_name
  subnet_id              = module.vpc.public_subnet_ids[0]
  security_group_id      = module.security_group.public_sg_id
  associate_public_ip    = true
  instance_name          = "Public-Host"
  attach_to_target_group = false
  target_group_arn       = null
}


module "key_pair" {
  source   = "./modules/key_pair"
  key_name = var.mod_key_name
}



