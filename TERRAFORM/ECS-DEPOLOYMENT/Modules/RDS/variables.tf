variable "project_name" {

  description = "Project Name"

  type = string

}

variable "db_identifier" {

  description = "RDS Identifier"

  type = string

}

variable "db_name" {

  description = "Database Name"

  type = string

}

variable "db_username" {

  description = "Master Username"

  type = string

}

variable "db_password" {

  description = "Master Password"

  type      = string
  sensitive = true

}

variable "db_instance_class" {

  description = "Instance Class"

  type = string

}

variable "allocated_storage" {

  description = "Allocated Storage"

  type = number

}

#variable "engine_version" {
# description = "MySQL Engine Version"
# type = string
#}

variable "private_db_subnet_ids" {

  description = "Private DB Subnets"

  type = list(string)

}

variable "rds_sg_id" {

  description = "RDS Security Group"

  type = string

}