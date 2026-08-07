variable "project_name" {

  description = "Project Name"

  type = string

}

variable "vpc_id" {

  description = "VPC ID"

  type = string

}

variable "public_subnet_ids" {

  description = "Public Subnet IDs"

  type = list(string)

}

variable "alb_sg_id" {

  description = "ALB Security Group"

  type = string

}

variable "alb_name" {
  type = string
}

variable "target_group_name" {

  description = "Target Group Name"

  type = string

}

variable "listener_port" {

  description = "Listener Port"

  type = number

}

variable "listener_protocol" {

  description = "Listener Protocol"

  type = string

}

variable "target_group_port" {

  description = "Target Group Port"

  type = number

}

variable "target_group_protocol" {

  description = "Target Group Protocol"

  type = string

}

variable "health_check_path" {

  description = "Health Check Path"

  type = string

}