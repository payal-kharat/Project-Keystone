variable "vpc_id" {
  type = string
}
variable "security_group_names" {
  type = list(string)
}
variable "SG_protocol" {
  type        = string
}
variable "SG_cidr_blocks" {
  type        = list(string)
}
variable "egress_protocol" {
  type        = string
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
