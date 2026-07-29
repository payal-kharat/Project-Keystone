
vpc_cidr = "10.0.0.0/16"

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

alb_ports = [
  80,
  443
]

app_ports = [
  80
]

db_ports = [
  3306
]

public_ports = [
22

]



db_name = "employee_db"

db_username = "Payal"

db_password = "Payal12345"

db_engine = "mysql"

db_engine_version = "8.0"

db_instance_class = "db.t3.micro"

allocated_storage = 20



alb_name = "three-tier-alb"

target_group_name = "three-tier-tg"



ami_id = "ami-01a00762f46d584a1"

instance_type = "t3.micro"

key_name = "demo"
