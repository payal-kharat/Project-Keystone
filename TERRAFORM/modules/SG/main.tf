resource "aws_security_group" "SG" {
  count = length(var.security_group_names)
  name        = var.security_group_names[count.index]
  vpc_id      = var.vpc_id

  tags = {
    Name = var.security_group_names[count.index]
  }
}


resource "aws_security_group_rule" "alb_ingress" {
  count = length(var.alb_ports)
  type = "ingress"
  from_port = var.alb_ports[count.index]
  to_port   = var.alb_ports[count.index]
  protocol = var.SG_protocol
  cidr_blocks = var.SG_cidr_blocks
  security_group_id = aws_security_group.SG[0].id
}


resource "aws_security_group_rule" "alb_egress" {
  count = length(var.alb_ports)
  type = "egress"
  from_port = var.alb_ports[count.index]
  to_port   = var.alb_ports[count.index]
  protocol = var.egress_protocol
  cidr_blocks = var.SG_cidr_blocks
  security_group_id = aws_security_group.SG[0].id
}



resource "aws_security_group_rule" "app_ingress" {
  count = length(var.app_ports)
  type = "ingress"
  from_port = var.app_ports[count.index]
  to_port   = var.app_ports[count.index]
  protocol = var.SG_protocol
  source_security_group_id = aws_security_group.SG[0].id
  security_group_id = aws_security_group.SG[1].id
}


resource "aws_security_group_rule" "app_egress" {
  count = length(var.app_ports)
  type = "egress"
  from_port = var.app_ports[count.index]
  to_port   = var.app_ports[count.index]
  protocol = var.egress_protocol
  cidr_blocks = var.SG_cidr_blocks
  security_group_id = aws_security_group.SG[1].id
}


resource "aws_security_group_rule" "db_ingress" {
  count = length(var.db_ports)
  type = "ingress"
  from_port = var.db_ports[count.index]
  to_port   = var.db_ports[count.index]
  protocol = var.SG_protocol
  source_security_group_id = aws_security_group.SG[1].id
  security_group_id = aws_security_group.SG[2].id
}


resource "aws_security_group_rule" "db_egress" {
  count = length(var.db_ports)
  type = "egress"
  from_port = var.db_ports[count.index]
  to_port   = var.db_ports[count.index]
  protocol = var.egress_protocol
  cidr_blocks = var.SG_cidr_blocks
  security_group_id = aws_security_group.SG[2].id
}


resource "aws_security_group_rule" "public_ingress" {
  count = length(var.public_ports)
  type = "ingress"
  from_port = var.public_ports[count.index]
  to_port   = var.public_ports[count.index]
  protocol = var.SG_protocol
  source_security_group_id = aws_security_group.SG[2].id
  security_group_id = aws_security_group.SG[3].id
}


resource "aws_security_group_rule" "public_egress" {
  count = length(var.public_ports)
  type = "egress"
  from_port = var.public_ports[count.index]
  to_port   = var.public_ports[count.index]
  protocol = var.egress_protocol
  cidr_blocks = var.SG_cidr_blocks
  security_group_id = aws_security_group.SG[3].id
}


