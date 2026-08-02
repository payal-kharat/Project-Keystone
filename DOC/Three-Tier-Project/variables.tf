
variable "vpc_cidr" {
  type        = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  type        = list(string)
}

variable "availability_zones" {
  type        = list(string)
}

# SG

variable "security_group_names" {
  type = list(string)
}

variable "alb_ports" {
  type = list(number)
}

variable "app_ports" {
  type = list(number)
}

variable "db_ports" {
  type = list(number)
}

variable "public_ports" {
  type = list(number)
}  


# RDS

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}


# ALB

variable "alb_name" {
  type = string
}

variable "target_group_name" {
  type = string
}


# EC2_Instnace

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}


