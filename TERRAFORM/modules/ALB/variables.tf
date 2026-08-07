variable "ALB_NAME" {
  type = string
}
variable "TARGATE_GROUP_NAME" {
  type = string
}
variable "ALB_TARGATE_TYPE" {
  type = string
}
variable "ALB_TARGATE_GROUP_PROTOCOL" {
  type = string
}
variable "ALB_TARGATE_PORT" {
  type = number
}
variable "LB_TYPE" {
  type = string
}
variable "ALB_LISTNER_PROTOCOL" {
  type = string
}
variable "ALB_LISTNER_PORT" {
  type = number
}
variable "VPC_ID" {
  type = string
}
variable "SUBNET_IDS" {
  type = list(string)
}
variable "SECURITY_GROUP_ID" {
  type = string
}
