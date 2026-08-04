
vpc_cidr                 = "10.0.0.0/16"
vpc_name                 = "three-tier-vpc"
igw_name                 = "three-tier-igw"
public_subnet_count      = 2
private_app_subnet_count = 2
private_db_subnet_count  = 2
nat_eip_name             = "nat-eip"
nat_gw_name              = "three-tier-nat"
public_RT_name           = "Public-RT"
private_RT_name          = "Private-RT"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_app_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

private_db_subnet_cidrs = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]

public_route_cidr       = "0.0.0.0/0"
private_route_cidr       = "0.0.0.0/0"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]



security_group_names = [
  "alb-sg",
  "app-sg",
  "db-sg" ,
  "public-sg"
]

SG_protocol = "tcp"
SG_cidr_blocks = [ "0.0.0.0/0" ]
egress_protocol = "-1"

alb_ports = [
  80,
  443
]

app_ports = [
  3000,
  80
  
]

db_ports = [
  3306
]

public_ports = [
22

]


db_subnet_group_name  = "DB-Subnet-Group"
db_name               = "employee_db"
db_username           = "Payal"
db_password           = "Payal12345"
db_engine             = "mysql"
db_engine_version     = "8.0"
db_instance_class     = "db.t3.micro"
allocated_storage     = 20
db_instance_name      = "Three-Tier-RDS"
db_storage_type       = "gp3"



alb_name                   = "three-tier-alb"
lb_type                    = "application"
target_group_name          = "three-tier-tg"
alb_targate_type           = "instance"
alb_targate_group_protocol = "HTTP"
alb_targate_port           = "80"
alb_listner_protocol       = "HTTP"
alb_listner_port           = "80"




ami_id        = "ami-01a00762f46d584a1"
instance_type = "t3.micro"
key_name      = "project-key"
