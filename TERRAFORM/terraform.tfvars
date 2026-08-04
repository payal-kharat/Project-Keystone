
mod_vpc_cidr                 = "10.0.0.0/16"
mod_vpc_name                 = "three-tier-vpc"
mod_igw_name                 = "three-tier-igw"
mod_public_subnet_count      = 2
mod_private_app_subnet_count = 2
mod_private_db_subnet_count  = 2
mod_nat_eip_name             = "nat-eip"
mod_nat_gw_name              = "three-tier-nat"
mod_public_RT_name           = "Public-RT"
mod_private_RT_name          = "Private-RT"

mod_public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

mod_private_app_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

mod_private_db_subnet_cidrs = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]

mod_public_route_cidr  = "0.0.0.0/0"
mod_private_route_cidr = "0.0.0.0/0"

mod_availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]



mod_security_group_names = [
  "alb-sg",
  "app-sg",
  "db-sg",
  "public-sg"
]

mod_SG_protocol     = "tcp"
mod_SG_cidr_blocks  = ["0.0.0.0/0"]
mod_egress_protocol = "-1"

mod_alb_ports = [
  80,
  443
]

mod_app_ports = [
  3000,
  80

]

mod_db_ports = [
  3306
]

mod_public_ports = [
  22

]


mod_db_subnet_group_name = "DB-Subnet-Group"
mod_db_name              = "employee_db"
mod_db_username          = "Payal"
mod_db_password          = "Payal12345"
mod_db_engine            = "mysql"
mod_db_engine_version    = "8.0"
mod_db_instance_class    = "db.t3.micro"
mod_allocated_storage    = 20
mod_db_instance_name     = "Three-Tier-RDS"
mod_db_storage_type      = "gp3"



mod_alb_name                   = "three-tier-alb"
mod_lb_type                    = "application"
mod_target_group_name          = "three-tier-tg"
mod_alb_targate_type           = "instance"
mod_alb_targate_group_protocol = "HTTP"
mod_alb_targate_port           = "80"
mod_alb_listner_protocol       = "HTTP"
mod_alb_listner_port           = "80"




mod_ami_id        = "ami-01a00762f46d584a1"
mod_instance_type = "t3.micro"
mod_key_name      = "project-key"
