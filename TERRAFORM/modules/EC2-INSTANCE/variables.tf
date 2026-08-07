variable "AMI_ID" {
  type = string
}
variable "INSTANCE_TYPE" {
  type = string
}
variable "KEY_NAME" {
  type = string
}
variable "SUBNET_ID" {
  type = string
}
variable "SECURITY_GROUP_ID" {
  type = string
}
variable "TARGATE_GROUP_ARN" {
  type = string
}
variable "ATTACH_TO_TARGATE_GROUP" {
  type = bool
}
variable "ASSOCIATE_PUBLIC_IP" {
  type = bool
}
variable "INSTANCE_NAME" {
  type = string
}
