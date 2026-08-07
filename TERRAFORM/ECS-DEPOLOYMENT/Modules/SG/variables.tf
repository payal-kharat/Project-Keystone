variable "project_name" {

  description = "Project Name"
  type        = string

}

variable "vpc_id" {

  description = "VPC ID"
  type        = string

}

variable "alb_ingress_port" {

  description = "ALB Listener Port"
  type        = number

}

variable "alb_ingress_protocol" {

  description = "ALB Protocol"
  type        = string

}

variable "alb_ingress_cidr" {

  description = "CIDR allowed to access ALB"
  type        = list(string)

}

variable "ecs_port" {

  description = "Container Port"
  type        = number

}

variable "ecs_protocol" {

  description = "ECS Protocol"
  type        = string

}

variable "db_port" {

  description = "Database Port"
  type        = number

}

variable "db_protocol" {

  description = "Database Protocol"
  type        = string

}