variable "project_name" {
  type        = string
}

variable "vpc_id" {
  type        = string
}

variable "alb_ingress_port" {
  type        = number
}

variable "alb_ingress_protocol" {
  type        = string
}

variable "alb_ingress_cidr" {
  type        = list(string)
}

variable "ecs_port" {
  type        = number
}

variable "ecs_protocol" {
  type        = string
}

variable "db_port" {
  type        = number
}

variable "db_protocol" {
  type        = string
}