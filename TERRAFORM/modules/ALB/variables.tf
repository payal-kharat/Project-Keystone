variable "alb_name" {
  type = string
}
variable "target_group_name" {
  type = string
}
variable "alb_targate_type" {
  type = string
}
variable "alb_targate_group_protocol" {
  type = string
}
variable "alb_targate_port" {
  type = number
}
variable "lb_type" {
  type = string
}
variable "alb_listner_protocol" {
  type = string
}
variable "alb_listner_port" {
  type = number
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {
  type = string
}
