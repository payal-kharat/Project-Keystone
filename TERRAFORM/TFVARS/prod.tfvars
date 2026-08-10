# PROD ENVIRONMENT
# VPC 

ENVIRONMENT = "prod"
MOD_VPC_CIDR = "10.30.0.0/16"
MOD_VPC_NAME = "three-tier-prod-vpc"
MOD_IGW_NAME = "three-tier-prod-igw"
MOD_PUBLIC_SUBNET_COUNT      = 2
MOD_PRIVATE_APP_SUBNET_COUNT = 2
MOD_PRIVATE_DB_SUBNET_COUNT  = 2
MOD_NAT_EIP_NAME = "three-tier-prod-nat-eip"
MOD_NAT_GW_NAME  = "three-tier-prod-nat-gw"
MOD_PUBLIC_ROUTE_CIDR = "0.0.0.0/0"
MOD_PUBLIC_RT_NAME    = "three-tier-prod-public-rt"
MOD_PRIVATE_ROUTE_CIDR = "0.0.0.0/0"
MOD_PRIVATE_RT_NAME    = "three-tier-prod-private-rt"
MOD_PUBLIC_SUBNET_CIDRS = [
  "10.30.1.0/24",
  "10.30.2.0/24"
]
MOD_PRIVATE_APP_SUBNET_CIDRS = [
  "10.30.3.0/24",
  "10.30.4.0/24"
]
MOD_PRIVATE_DB_SUBNET_CIDRS = [
  "10.30.5.0/24",
  "10.30.6.0/24"
]
MOD_AVAILABILITY_ZONES = [
  "ap-south-1a",
  "ap-south-1b"
]


# SECURITY GROUP 

MOD_SECURITY_GROUP_NAMES = [
  "three-tier-prod-alb-sg",
  "three-tier-prod-app-sg",
  "three-tier-prod-db-sg"
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
MOD_DB_SUBNET_GROUP_NAME = "three-tier-prod-db-subnet-group"
MOD_DB_INSTANCE_NAME = "three-tier-prod-db"
MOD_DB_USERNAME = "admin"
MOD_DB_PASSWORD = "CHANGE_ME"
MOD_DB_ENGINE = "mysql"
MOD_DB_STORAGE_TYPE = "gp3"
MOD_DB_ENGINE_VERSION = "8.0"
MOD_DB_INSTANCE_CLASS = "db.t3.medium"
MOD_ALLOCATED_STORAGE = 50

# ALB 

MOD_ALB_NAME = "three-tier-prod-alb"
MOD_LB_TYPE = "application"
MOD_ALB_TARGATE_TYPE = "ip"
MOD_ALB_TARGATE_GROUP_PROTOCOL = "HTTP"
MOD_ALB_TARGATE_PORT = 80
MOD_ALB_LISTNER_PROTOCOL = "HTTP"
MOD_ALB_LISTNER_PORT = 80
MOD_TARGATE_GROUP_NAME = "three-tier-prod-tg"

# EC2 

MOD_AMI_ID = "ami-xxxxxxxxxxxxxxxxx"
MOD_INSTANCE_TYPE = "t3.medium"
MOD_KEY_NAME = "your-prod-key"
