variable "PROJECT_NAME" {
  type = string
}

variable "TASK_FAMILY" {
  type = string
}

variable "CPU" {
  type = number
}

variable "MEMORY" {
  type = number
}

variable "EXECUTION_ROLE_ARN" {
  type = string
}

variable "TASK_ROLE_ARN" {
  type = string
}

variable "FRONTEND_IMAGE" {
  type = string
}

variable "BACKEND_IMAGE" {
  type = string
}

variable "AWS_REGION" {
  type = string
}

variable "DB_HOST" {
  type = string
}

variable "DB_NAME" {
  type = string
}

variable "DB_USER" {
  type = string
}

variable "DB_PASSWORD" {
  type      = string
  sensitive = true
}