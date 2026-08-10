# VPC
MOD_VPC_CIDR                 = "10.0.0.0/16"
MOD_VPC_NAME                 = "three-tier-vpc"
MOD_IGW_NAME                 = "three-tier-igw"
MOD_PUBLIC_SUBNET_COUNT      = 2
MOD_PRIVATE_APP_SUBNET_COUNT = 2
MOD_PRIVATE_DB_SUBNET_COUNT  = 2
MOD_NAT_EIP_NAME             = "nat-eip"
MOD_NAT_GW_NAME              = "three-tier-nat"
MOD_PUBLIC_RT_NAME           = "Public-RT"
MOD_PRIVATE_RT_NAME          = "Private-RT"
MOD_PUBLIC_SUBNET_CIDRS = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
MOD_PRIVATE_APP_SUBNET_CIDRS = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]
MOD_PRIVATE_DB_SUBNET_CIDRS = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]
MOD_PUBLIC_ROUTE_CIDR  = "0.0.0.0/0"
MOD_PRIVATE_ROUTE_CIDR = "0.0.0.0/0"
MOD_AVAILABILITY_ZONES = [
  "ap-south-1a",
  "ap-south-1b"
]

MOD_SECURITY_GROUPS = {
  alb = {
    name = "ecs-three-tier-alb-sg"
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  app = {
    name = "ecs-three-tier-app-sg"
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  db = {
    name = "ecs-three-tier-db-sg"
    ingress_rules = [
      {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  public = {
    name = "ecs-three-tier-public-sg"
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

MOD_DB_SUBNET_GROUP_NAME = "DB-Subnet-Group"
MOD_DB_NAME              = "employee_db"
MOD_DB_USERNAME          = "YOUR_USERNAME"
MOD_DB_PASSWORD          = "YOUR_PASS"
MOD_DB_ENGINE            = "mysql"
MOD_DB_ENGINE_VERSION    = "8.0"
MOD_DB_INSTANCE_CLASS    = "db.t3.micro"
MOD_ALLOCATED_STORAGE    = 20
MOD_DB_INSTANCE_NAME     = "Three-Tier-RDS"
MOD_DB_STORAGE_TYPE      = "gp3"

MOD_ALB_NAME                   = "three-tier-alb"
MOD_LB_TYPE                    = "application"
MOD_TARGATE_GROUP_NAME         = "three-tier-tg"
MOD_ALB_TARGATE_TYPE           = "instance"
MOD_ALB_TARGATE_GROUP_PROTOCOL = "HTTP"
MOD_ALB_TARGATE_PORT           = "80"
MOD_ALB_LISTNER_PROTOCOL       = "HTTP"
MOD_ALB_LISTNER_PORT           = "80"
MOD_ALB_PROTOCOL               = "tcp"
MOD_ALB_CIDR_BLOCKS            = ["0.0.0.0/0"]

MOD_AMI_ID        = "ami-xxxxxxxxxxxxxx"
MOD_INSTANCE_TYPE = "t3.micro"
MOD_KEY_NAME      = "project-key"
