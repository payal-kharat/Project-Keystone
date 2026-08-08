variable "PROJECT_NAME" {
  type = string
}

variable "SERVICE_NAME" {
  type = string
}

variable "CLUSTER_ID" {
  type = string
}

variable "TASK_DEFINITION_ARN" {
  type = string
}

variable "DESIRED_COUNT" {
  type = number
}

variable "PRIVATE_APP_SUBNET_IDS" {
  type = list(string)
}

variable "ECS_SG_ID" {
  type = string
}

variable "TARGET_GROUP_ARN" {
  type = string
}

variable "FRONTEND_CONTAINER_NAME" {
  type = string
}

variable "FRONTEND_CONTAINER_PORT" {
  type = number
}