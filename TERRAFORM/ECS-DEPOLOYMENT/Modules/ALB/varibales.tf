variable "PROJECT_NAME" {
  type = string
}

variable "VPC_ID" {
  type = string
}

variable "PUBLIC_SUBNET_IDS" {
  type = list(string)
}

variable "ALB_SG_ID" {
  type = string
}

variable "ALB_NAME" {
  type = string
}

variable "TARGET_GROUP_NAME" {
  type = string
}

variable "LISTENER_PORT" {
  type = number
}

variable "LISTENER_PROTOCOL" {
  type = string
}

variable "TARGET_GROUP_PORT" {
  type = number
}

variable "TARGET_GROUP_PROTOCOL" {
  type = string
}

variable "HEALTH_CHECK_PATH" {
  type = string
}