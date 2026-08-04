variable "vpc_cidr" {
type = string
}

variable "vpc_name" {
type = string
}

variable "igw_name" {
type = string
}

variable "public_subnet_count" {
type = number
}

variable "private_app_subnet_count" {
type = number
}


variable "private_db_subnet_count" {
type = number
}

variable "nat_eip_name" {
type = string
}

variable "nat_gw_name" {
type = string
}

variable "public_route_cidr" {
type = string
}

variable "public_RT_name" {
type = string
}

variable "private_route_cidr" {
type = string
}

variable "private_RT_name" {
type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_app_subnet_cidrs" {
  type = list(string)
}

variable "private_db_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}
