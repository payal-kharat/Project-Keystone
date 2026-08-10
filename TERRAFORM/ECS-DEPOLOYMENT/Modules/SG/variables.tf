variable "VPC_ID" {
  type = string
}

variable "SECURITY_GROUPS" {

  type = map(object({

    name = string

    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))

    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))

  }))
}