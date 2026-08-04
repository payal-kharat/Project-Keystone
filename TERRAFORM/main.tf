# VPC

module "vpc" {
  source                   = "./modules/vpc"

  vpc_cidr                 = var.vpc_cidr
  vpc_name                 = var.vpc_name
  igw_name                 = var.igw_name
  public_subnet_count      = var.public_subnet_count
  private_app_subnet_count = var.private_app_subnet_count
  private_db_subnet_count  = var.private_db_subnet_count
  nat_eip_name             = var.nat_eip_name
  nat_gw_name              = var.nat_gw_name
  public_route_cidr        = var.public_route_cidr
  public_RT_name           = var.public_RT_name
  private_route_cidr       = var.private_route_cidr
  private_RT_name          = var.private_RT_name
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  availability_zones       = var.availability_zones
}

#SG

module "security_group" {

  source                = "./modules/SG"
  vpc_id                = module.vpc.vpc_id
  security_group_names  = var.security_group_names
  SG_protocol           = var.SG_protocol
  SG_cidr_blocks        = var.SG_cidr_blocks
  egress_protocol       = var.egress_protocol
  alb_ports             = var.alb_ports
  app_ports             = var.app_ports
  db_ports              = var.db_ports
  public_ports          = var.public_ports

}


# RDS

module "rds" {
  source              = "./modules/RDS"

  db_name             = var.db_name
  db_subnet_group_name= var.db_subnet_group_name
  db_instance_name    = var.db_instance_name
  db_username         = var.db_username
  db_password         = var.db_password
  db_engine           = var.db_engine
  db_engine_version   = var.db_engine_version
  db_instance_class   = var.db_instance_class
  allocated_storage   = var.allocated_storage
  db_storage_type     = var.db_storage_type
  subnet_ids          = module.vpc.private_db_subnet_ids
  security_group_id   = module.security_group.db_sg_id

}

# ALB

module "alb" {
  source                     = "./modules/ALB"

  alb_name                   = var.alb_name
  lb_type                    = var.lb_type
  alb_targate_type           = var.alb_targate_type
  target_group_name          = var.target_group_name
  alb_targate_group_protocol = var.alb_targate_group_protocol
  alb_targate_port           = var.alb_targate_port
  alb_listner_protocol       = var.alb_listner_protocol
  alb_listner_port           = var.alb_listner_port
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.public_subnet_ids
  security_group_id          = module.security_group.alb_sg_id

}

# EC2_Instances

module "ec2" {
 source                   = "./modules/EC2_Instance"

  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  key_name                = module.key_pair.key_name
  associate_public_ip     = false
  instance_name           = "application_Host"
  subnet_id               = module.vpc.private_app_subnet_ids[0]
  security_group_id       = module.security_group.app_sg_id
  attach_to_target_group = true
  target_group_arn        = module.alb.target_group_arn
}


module "public_ec2" {
  source = "./modules/EC2_Instance"

  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  key_name               = module.key_pair.key_name
  subnet_id              = module.vpc.public_subnet_ids[0]
  security_group_id      = module.security_group.public_sg_id
  associate_public_ip    = true
  instance_name          = "Public-Host"
  attach_to_target_group = false
  target_group_arn       = null
}


module "key_pair" {

  source        = "./modules/key_pair"
  key_name      = var.key_name
}



