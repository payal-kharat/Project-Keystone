variable "vpc_id" {
  type = string
}

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
