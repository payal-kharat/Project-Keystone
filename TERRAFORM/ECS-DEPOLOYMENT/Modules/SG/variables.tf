variable "PROJECT_NAME" {
  type = string
}

variable "VPC_ID" {
  type = string
}

variable "ALB_INGRESS_PORT" {
  type = number
}

variable "ALB_INGRESS_PROTOCOL" {
  type = string
}

variable "ALB_INGRESS_CIDR" {
  type = list(string)
}

variable "ECS_PORT" {
  type = number
}

variable "ECS_PROTOCOL" {
  type = string
}

variable "DB_PORT" {
  type = number
}

variable "DB_PROTOCOL" {
  type = string
}