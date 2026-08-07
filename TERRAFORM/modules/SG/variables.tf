variable "VPC_ID" {
  type = string
}
variable "SECURITY_GROUP_NAMES" {
  type = list(string)
}
variable "SG_PROTOCOL" {
  type = string
}
variable "SG_CIDR_BLOCKS" {
  type = list(string)
}
variable "EGRESS_PROTOCOL" {
  type = string
}
variable "ALB_PORTS" {
  type = list(number)
}
variable "APP_PORTS" {
  type = list(number)
}
variable "DB_PORTS" {
  type = list(number)
}
variable "PUBLIC_PORTS" {
  type = list(number)
}
