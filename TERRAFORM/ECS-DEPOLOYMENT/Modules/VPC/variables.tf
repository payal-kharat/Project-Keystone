variable "VPC_CIDR" {
  type = string
}

variable "PUBLIC_SUBNETS" {
  type = list(string)
}

variable "PRIVATE_APP_SUBNETS" {
  type = list(string)
}

variable "PRIVATE_DB_SUBNETS" {
  type = list(string)
}

variable "AVAILABILITY_ZONES" {
  type = list(string)
}

variable "PROJECT_NAME" {
  type = string
}