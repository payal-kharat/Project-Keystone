AWS_REGION = "ap-south-1"
PROJECT_NAME = "ecs-three-tier"
VPC_CIDR = "10.0.0.0/16"
PUBLIC_SUBNETS = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
PRIVATE_APP_SUBNETS = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]
PRIVATE_DB_SUBNETS = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]
AVAILABILITY_ZONES = [
  "ap-south-1a",
  "ap-south-1b"
]

#SG

ALB_INGRESS_PORT = 80
ALB_INGRESS_PROTOCOL = "tcp"
ALB_INGRESS_CIDR = [
  "0.0.0.0/0"
]
ECS_PORT = 80
ECS_PROTOCOL = "tcp"
DB_PORT = 3306
DB_PROTOCOL = "tcp"


# ECR

FRONTEND_REPOSITORY_NAME = "react-frontend"
BACKEND_REPOSITORY_NAME = "node-backend"

#ALB


ALB_NAME = "three-tier-alb"
TARGET_GROUP_NAME = "three-tier-tg"
LISTENER_PORT = 80
LISTENER_PROTOCOL = "HTTP"
TARGET_GROUP_PORT = 80
TARGET_GROUP_PROTOCOL = "HTTP"
HEALTH_CHECK_PATH = "/"

# ECS Cluster

CLUSTER_NAME = "three-tier-cluster"

# RDS

DB_IDENTIFIER = "three-tier-db"
DB_NAME = "employee_db"
DB_USERNAME = "YOUR_USERNAME"
DB_PASSWORD = "YOUR_PASS"
DB_INSTANCE_CLASS = "db.t3.micro"
ALLOCATED_STORAGE = 20
#engine_version = "8.0.41"

# ECS Task

TASK_FAMILY = "three-tier-task"
CPU = 512
MEMORY = 1024
FRONTEND_IMAGE = "106295460257.dkr.ecr.ap-south-1.amazonaws.com/node-app:frontend"
BACKEND_IMAGE = "106295460257.dkr.ecr.ap-south-1.amazonaws.com/node-app:backend1"

# ECS Service

SERVICE_NAME = "three-tier-service"
DESIRED_COUNT = 1
FRONTEND_CONTAINER_NAME = "frontend"
FRONTEND_CONTAINER_PORT = 80
