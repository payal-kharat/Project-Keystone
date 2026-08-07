variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_app_subnets" {
  description = "Private application subnet CIDRs"
  type        = list(string)
}

variable "private_db_subnets" {
  description = "Private database subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

# SG

variable "alb_ingress_port" {
  type = number
}

variable "alb_ingress_protocol" {
  type = string
}

variable "alb_ingress_cidr" {
  type = list(string)
}

variable "ecs_port" {
  type = number
}

variable "ecs_protocol" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_protocol" {
  type = string
}

#ECR
variable "frontend_repository_name" {

  type = string

}

variable "backend_repository_name" {

  type = string

}

# ALB
variable "alb_name" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "listener_port" {
  type = number
}

variable "listener_protocol" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  type = string
}

variable "health_check_path" {
  type = string
}

#ECS-Cluster
variable "cluster_name" {

  type = string

}
#RDS
variable "db_identifier" {

  type = string

}

variable "db_name" {

  type = string

}

variable "db_username" {

  type = string

}

variable "db_password" {

  type = string

  sensitive = true

}

variable "db_instance_class" {

  type = string

}

variable "allocated_storage" {

  type = number

}

#variable "engine_version" {
#type = string
#}

# ECS-Task


variable "task_family" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "frontend_image" {
  type = string
}

variable "backend_image" {
  type = string
}


# ECS Service


variable "service_name" {

  type = string

}

variable "desired_count" {

  type = number

}

variable "frontend_container_name" {

  type = string

}

variable "frontend_container_port" {

  type = number

}