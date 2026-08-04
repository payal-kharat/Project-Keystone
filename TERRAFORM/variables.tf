#VPC
variable "mod_vpc_cidr" {
  type = string
}
variable "mod_vpc_name" {
  type = string
}
variable "mod_igw_name" {
  type = string
}
variable "mod_public_subnet_count" {
  type = number
}

variable "mod_private_app_subnet_count" {
  type = number
}

variable "mod_private_db_subnet_count" {
  type = number
}
variable "mod_nat_eip_name" {
  type = string
}
variable "mod_nat_gw_name" {
  type = string
}

variable "mod_public_route_cidr" {
  type = string
}
variable "mod_public_RT_name" {
  type = string
}
variable "mod_private_route_cidr" {
  type = string
}
variable "mod_private_RT_name" {
  type = string
}

variable "mod_public_subnet_cidrs" {
  type = list(string)
}

variable "mod_private_app_subnet_cidrs" {
  type = list(string)
}

variable "mod_private_db_subnet_cidrs" {
  type = list(string)
}

variable "mod_availability_zones" {
  type = list(string)
}

# SG

variable "mod_security_group_names" {
  type = list(string)
}
variable "mod_alb_protocol" {
  type = string
}

variable "mod_SG_protocol" {
  type = string
}

variable "mod_SG_cidr_blocks" {
  type = list(string)
}

variable "mod_egress_protocol" {
  type = string
}

variable "mod_alb_cidr_blocks" {
  type = list(string)
}

variable "mod_alb_ports" {
  type = list(number)
}

variable "mod_app_ports" {
  type = list(number)
}

variable "mod_db_ports" {
  type = list(number)
}

variable "mod_public_ports" {
  type = list(number)
}


# RDS

variable "mod_db_name" {
  type = string
}
variable "mod_db_subnet_group_name" {
  type = string
}
variable "mod_db_instance_name" {
  type = string
}

variable "mod_db_username" {
  type = string
}

variable "mod_db_password" {
  type      = string
  sensitive = true
}

variable "mod_db_engine" {
  type = string
}
variable "mod_db_storage_type" {
  type = string
}

variable "mod_db_engine_version" {
  type = string
}

variable "mod_db_instance_class" {
  type = string
}

variable "mod_allocated_storage" {
  type = number
}


# ALB

variable "mod_alb_name" {
  type = string
}
variable "mod_lb_type" {
  type = string
}
variable "mod_alb_targate_type" {
  type = string
}
variable "mod_alb_targate_group_protocol" {
  type = string
}
variable "mod_alb_targate_port" {
  type = number
}
variable "mod_alb_listner_protocol" {
  type = string
}
variable "mod_alb_listner_port" {
  type = number
}
variable "mod_target_group_name" {
  type = string
}


# EC2_Instnace

variable "mod_ami_id" {
  type = string
}

variable "mod_instance_type" {
  type = string
}

variable "mod_key_name" {
  type = string
}


