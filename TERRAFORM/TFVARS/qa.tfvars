# QA ENVIRONMENT
# VPC

ENVIRONMENT = "qa"
MOD_VPC_CIDR = "10.10.0.0/16"
MOD_VPC_NAME = "three-tier-qa-vpc"
MOD_IGW_NAME = "three-tier-qa-igw"
MOD_PUBLIC_SUBNET_COUNT      = 2
MOD_PRIVATE_APP_SUBNET_COUNT = 2
MOD_PRIVATE_DB_SUBNET_COUNT  = 2
MOD_NAT_EIP_NAME = "three-tier-qa-nat-eip"
MOD_NAT_GW_NAME  = "three-tier-qa-nat-gw"
MOD_PUBLIC_ROUTE_CIDR = "0.0.0.0/0"
MOD_PUBLIC_RT_NAME    = "three-tier-qa-public-rt"
MOD_PRIVATE_ROUTE_CIDR = "0.0.0.0/0"
MOD_PRIVATE_RT_NAME    = "three-tier-qa-private-rt"
MOD_PUBLIC_SUBNET_CIDRS = [
  "10.10.1.0/24",
  "10.10.2.0/24"
]
MOD_PRIVATE_APP_SUBNET_CIDRS = [
  "10.10.3.0/24",
  "10.10.4.0/24"
]
MOD_PRIVATE_DB_SUBNET_CIDRS = [
  "10.10.5.0/24",
  "10.10.6.0/24"
]
MOD_AVAILABILITY_ZONES = [
  "ap-south-1a",
  "ap-south-1b"
]


# SECURITY GROUP 

MOD_SECURITY_GROUP_NAMES = [
  "three-tier-qa-alb-sg",
  "three-tier-qa-app-sg",
  "three-tier-qa-db-sg"
]
MOD_ALB_PROTOCOL    = "tcp"
MOD_SG_PROTOCOL     = "tcp"
MOD_EGRESS_PROTOCOL = "-1"
MOD_SG_CIDR_BLOCKS = [
  "0.0.0.0/0"
]
MOD_ALB_CIDR_BLOCKS = [
  "0.0.0.0/0"
]
MOD_ALB_PORTS = [
  80
]
MOD_APP_PORTS = [
  80
]
MOD_DB_PORTS = [
  3306
]
MOD_PUBLIC_PORTS = [
  80
]

# RDS

MOD_DB_NAME = "appdb"
MOD_DB_SUBNET_GROUP_NAME = "three-tier-qa-db-subnet-group"
MOD_DB_INSTANCE_NAME = "three-tier-qa-db"
MOD_DB_USERNAME = "admin"
MOD_DB_PASSWORD = "CHANGE_ME"
MOD_DB_ENGINE = "mysql"
MOD_DB_STORAGE_TYPE = "gp3"
MOD_DB_ENGINE_VERSION = "8.0"
MOD_DB_INSTANCE_CLASS = "db.t3.micro"
MOD_ALLOCATED_STORAGE = 20

# ALB

MOD_ALB_NAME = "three-tier-qa-alb"
MOD_LB_TYPE = "application"
MOD_ALB_TARGATE_TYPE = "ip"
MOD_ALB_TARGATE_GROUP_PROTOCOL = "HTTP"
MOD_ALB_TARGATE_PORT = 80
MOD_ALB_LISTNER_PROTOCOL = "HTTP"
MOD_ALB_LISTNER_PORT = 80
MOD_TARGATE_GROUP_NAME = "three-tier-qa-tg"

# EC2

MOD_AMI_ID = "ami-xxxxxxxxxxxxxxxxx"
MOD_INSTANCE_TYPE = "t3.micro"
MOD_KEY_NAME = "your-qa-key"
