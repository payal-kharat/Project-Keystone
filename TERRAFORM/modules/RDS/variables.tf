variable "db_name" {
  type = string
}
variable "db_subnet_group_name" {
  type = string
}
variable "db_instance_name" {
  type = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
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
variable "db_storage_type" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {
  type = string
}
