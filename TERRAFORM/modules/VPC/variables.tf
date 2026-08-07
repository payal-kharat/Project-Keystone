variable "VPC_CIDR" {
  type = string
}

variable "VPC_NAME" {
  type = string
}

variable "IGW_NAME" {
  type = string
}

variable "PUBLIC_SUBNET_COUNT" {
  type = number
}

variable "PRIVATE_APP_SUBNET_COUNT" {
  type = number
}

variable "PRIVATE_DB_SUBNET_COUNT" {
  type = number
}

variable "NAT_EIP_NAME" {
  type = string
}

variable "NAT_GW_NAME" {
  type = string
}

variable "PUBLIC_ROUTE_CIDR" {
  type = string
}

variable "PUBLIC_RT_NAME" {
  type = string
}

variable "PRIVATE_ROUTE_CIDR" {
  type = string
}

variable "PRIVATE_RT_NAME" {
  type = string
}

variable "PUBLIC_SUBNET_CIDRS" {
  type = list(string)
}

variable "PRIVATE_APP_SUBNET_CIDRS" {
  type = list(string)
}

variable "PRIVATE_DB_SUBNET_CIDRS" {
  type = list(string)
}

variable "AVAILABILITY_ZONES" {
  type = list(string)
}