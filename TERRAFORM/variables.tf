#VPC
variable "MOD_VPC_CIDR" {
  type = string
}
variable "MOD_VPC_NAME" {
  type = string
}
variable "MOD_IGW_NAME" {
  type = string
}
variable "MOD_PUBLIC_SUBNET_COUNT" {
  type = number
}

variable "MOD_PRIVATE_APP_SUBNET_COUNT" {
  type = number
}

variable "MOD_PRIVATE_DB_SUBNET_COUNT" {
  type = number
}
variable "MOD_NAT_EIP_NAME" {
  type = string
}
variable "MOD_NAT_GW_NAME" {
  type = string
}

variable "MOD_PUBLIC_ROUTE_CIDR" {
  type = string
}
variable "MOD_PUBLIC_RT_NAME" {
  type = string
}
variable "MOD_PRIVATE_ROUTE_CIDR" {
  type = string
}
variable "MOD_PRIVATE_RT_NAME" {
  type = string
}

variable "MOD_PUBLIC_SUBNET_CIDRS" {
  type = list(string)
}

variable "MOD_PRIVATE_APP_SUBNET_CIDRS" {
  type = list(string)
}

variable "MOD_PRIVATE_DB_SUBNET_CIDRS" {
  type = list(string)
}

variable "MOD_AVAILABILITY_ZONES" {
  type = list(string)
}

# SG

variable "MOD_SECURITY_GROUP_NAMES" {
  type = list(string)
}
variable "MOD_ALB_PROTOCOL" {
  type = string
}

variable "MOD_SG_PROTOCOL" {
  type = string
}

variable "MOD_SG_CIDR_BLOCKS" {
  type = list(string)
}

variable "MOD_EGRESS_PROTOCOL" {
  type = string
}

variable "MOD_ALB_CIDR_BLOCKS" {
  type = list(string)
}

variable "MOD_ALB_PORTS" {
  type = list(number)
}

variable "MOD_APP_PORTS" {
  type = list(number)
}

variable "MOD_DB_PORTS" {
  type = list(number)
}

variable "MOD_PUBLIC_PORTS" {
  type = list(number)
}


# RDS

variable "MOD_DB_NAME" {
  type = string
}
variable "MOD_DB_SUBNET_GROUP_NAME" {
  type = string
}
variable "MOD_DB_INSTANCE_NAME" {
  type = string
}

variable "MOD_DB_USERNAME" {
  type = string
}

variable "MOD_DB_PASSWORD" {
  type      = string
  sensitive = true
}

variable "MOD_DB_ENGINE" {
  type = string
}
variable "MOD_DB_STORAGE_TYPE" {
  type = string
}

variable "MOD_DB_ENGINE_VERSION" {
  type = string
}

variable "MOD_DB_INSTANCE_CLASS" {
  type = string
}

variable "MOD_ALLOCATED_STORAGE" {
  type = number
}


# ALB

variable "MOD_ALB_NAME" {
  type = string
}
variable "MOD_LB_TYPE" {
  type = string
}
variable "MOD_ALB_TARGATE_TYPE" {
  type = string
}
variable "MOD_ALB_TARGATE_GROUP_PROTOCOL" {
  type = string
}
variable "MOD_ALB_TARGATE_PORT" {
  type = number
}
variable "MOD_ALB_LISTNER_PROTOCOL" {
  type = string
}
variable "MOD_ALB_LISTNER_PORT" {
  type = number
}
variable "MOD_TARGATE_GROUP_NAME" {
  type = string
}


# EC2_Instnace

variable "MOD_AMI_ID" {
  type = string
}

variable "MOD_INSTANCE_TYPE" {
  type = string
}

variable "MOD_KEY_NAME" {
  type = string
}


