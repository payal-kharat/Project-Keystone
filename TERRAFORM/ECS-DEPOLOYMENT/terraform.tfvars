aws_region = "ap-south-1"
project_name = "ecs-three-tier"
vpc_cidr = "10.0.0.0/16"
public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
private_app_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]
private_db_subnets = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]
availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

#SG

alb_ingress_port = 80
alb_ingress_protocol = "tcp"
alb_ingress_cidr = [
  "0.0.0.0/0"
]
ecs_port = 80
ecs_protocol = "tcp"
db_port = 3306
db_protocol = "tcp"


# ECR

frontend_repository_name = "react-frontend"
backend_repository_name = "node-backend"

#ALB


alb_name = "three-tier-alb"
target_group_name = "three-tier-tg"
listener_port = 80
listener_protocol = "HTTP"
target_group_port = 80
target_group_protocol = "HTTP"
health_check_path = "/"


# ECS Cluster

cluster_name = "three-tier-cluster"


# RDS

db_identifier = "three-tier-db"
db_name = "employee_db"
db_username = "Payal"
db_password = "Payal12345"
db_instance_class = "db.t3.micro"
allocated_storage = 20
#engine_version = "8.0.41"


# ECS Task

task_family = "three-tier-task"
cpu = 512
memory = 1024
frontend_image = "106295460257.dkr.ecr.ap-south-1.amazonaws.com/node-app:frontend"
backend_image = "106295460257.dkr.ecr.ap-south-1.amazonaws.com/node-app:backend1"


# ECS Service

service_name = "three-tier-service"
desired_count = 1
frontend_container_name = "frontend"
frontend_container_port = 80