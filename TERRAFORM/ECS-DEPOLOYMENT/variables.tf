variable "AWS_REGION" {
  type = string
}
variable "PROJECT_NAME" {
  type = string
}
variable "VPC_CIDR" {
  type = string
}
variable "PUBLIC_SUBNETS" {
  type = list(string)
}
variable "PRIVATE_APP_SUBNETS" {
  type = list(string)
}
variable "PRIVATE_DB_SUBNETS" {
  type = list(string)
}
variable "AVAILABILITY_ZONES" {
  type = list(string)
}

# SG
variable "SECURITY_GROUPS" {
  type = map(object({
    name = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}

# ECR

variable "FRONTEND_REPOSITORY_NAME" {
  type = string
}
variable "BACKEND_REPOSITORY_NAME" {
  type = string
}

# ALB

variable "ALB_NAME" {
  type = string
}
variable "TARGET_GROUP_NAME" {
  type = string
}
variable "LISTENER_PORT" {
  type = number
}
variable "LISTENER_PROTOCOL" {
  type = string
}
variable "TARGET_GROUP_PORT" {
  type = number
}
variable "TARGET_GROUP_PROTOCOL" {
  type = string
}
variable "HEALTH_CHECK_PATH" {
  type = string
}

# ECS Cluster

variable "CLUSTER_NAME" {
  type = string
}

# RDS

variable "DB_IDENTIFIER" {
  type = string
}

variable "DB_NAME" {
  type = string
}
variable "DB_USERNAME" {
  type = string
}
variable "DB_PASSWORD" {
  type      = string
  sensitive = true
}
variable "DB_INSTANCE_CLASS" {
  type = string
}

variable "ALLOCATED_STORAGE" {
  type = number
}

# variable "ENGINE_VERSION" {
#   type = string
# }

# ECS Task

variable "TASK_FAMILY" {
  type = string
}
variable "CPU" {
  type = number
}
variable "MEMORY" {
  type = number
}
variable "FRONTEND_IMAGE" {
  type = string
}
variable "BACKEND_IMAGE" {
  type = string
}

# ECS Service

variable "SERVICE_NAME" {
  type = string
}
variable "DESIRED_COUNT" {
  type = number
}
variable "FRONTEND_CONTAINER_NAME" {
  type = string
}

variable "FRONTEND_CONTAINER_PORT" {
  type = number
}
