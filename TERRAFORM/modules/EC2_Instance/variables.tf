variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "security_group_id" {
  type = string
}
variable "target_group_arn" {
  type = string
}
variable "attach_to_target_group" {
  type = bool
}
variable "associate_public_ip" {
  type = bool
}
variable "instance_name" {
  type = string
}
