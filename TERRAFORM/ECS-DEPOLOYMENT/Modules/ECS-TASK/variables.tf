variable "project_name" {
  type = string
}

variable "task_family" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "frontend_image" {
  type = string
}

variable "backend_image" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}