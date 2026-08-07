resource "aws_security_group" "this_sg" {
  count  = length(var.SECURITY_GROUP_NAMES)
  name   = var.SECURITY_GROUP_NAMES[count.index]
  vpc_id = var.VPC_ID

  tags = {
    Name = var.SECURITY_GROUP_NAMES[count.index]
  }
}


resource "aws_security_group_rule" "this_alb_ingress" {
  count             = length(var.ALB_PORTS)
  type              = "ingress"
  from_port         = var.ALB_PORTS[count.index]
  to_port           = var.ALB_PORTS[count.index]
  protocol          = var.SG_PROTOCOL
  cidr_blocks       = var.SG_CIDR_BLOCKS
  security_group_id = aws_security_group.this_sg[0].id
}


resource "aws_security_group_rule" "this_alb_egress" {
  count             = length(var.ALB_PORTS)
  type              = "egress"
  from_port         = var.ALB_PORTS[count.index]
  to_port           = var.ALB_PORTS[count.index]
  protocol          = var.EGRESS_PROTOCOL
  cidr_blocks       = var.SG_CIDR_BLOCKS
  security_group_id = aws_security_group.this_sg[0].id
}



resource "aws_security_group_rule" "this_app_ingress" {
  count                    = length(var.APP_PORTS)
  type                     = "ingress"
  from_port                = var.APP_PORTS[count.index]
  to_port                  = var.APP_PORTS[count.index]
  protocol                 = var.SG_PROTOCOL
  source_security_group_id = aws_security_group.this_sg[0].id
  security_group_id        = aws_security_group.this_sg[1].id
}


resource "aws_security_group_rule" "this_app_egress" {
  count             = length(var.APP_PORTS)
  type              = "egress"
  from_port         = var.APP_PORTS[count.index]
  to_port           = var.APP_PORTS[count.index]
  protocol          = var.EGRESS_PROTOCOL
  cidr_blocks       = var.SG_CIDR_BLOCKS
  security_group_id = aws_security_group.this_sg[1].id
}


resource "aws_security_group_rule" "this_db_ingress" {
  count                    = length(var.DB_PORTS)
  type                     = "ingress"
  from_port                = var.DB_PORTS[count.index]
  to_port                  = var.DB_PORTS[count.index]
  protocol                 = var.SG_PROTOCOL
  source_security_group_id = aws_security_group.this_sg[1].id
  security_group_id        = aws_security_group.this_sg[2].id
}


resource "aws_security_group_rule" "this_db_egress" {
  count             = length(var.DB_PORTS)
  type              = "egress"
  from_port         = var.DB_PORTS[count.index]
  to_port           = var.DB_PORTS[count.index]
  protocol          = var.EGRESS_PROTOCOL
  cidr_blocks       = var.SG_CIDR_BLOCKS
  security_group_id = aws_security_group.this_sg[2].id
}


resource "aws_security_group_rule" "this_public_ingress" {
  count                    = length(var.PUBLIC_PORTS)
  type                     = "ingress"
  from_port                = var.PUBLIC_PORTS[count.index]
  to_port                  = var.PUBLIC_PORTS[count.index]
  protocol                 = var.SG_PROTOCOL
  source_security_group_id = aws_security_group.this_sg[2].id
  security_group_id        = aws_security_group.this_sg[3].id
}

resource "aws_security_group_rule" "this_public_egress" {
  count             = length(var.PUBLIC_PORTS)
  type              = "egress"
  from_port         = var.PUBLIC_PORTS[count.index]
  to_port           = var.PUBLIC_PORTS[count.index]
  protocol          = var.EGRESS_PROTOCOL
  cidr_blocks       = var.SG_CIDR_BLOCKS
  security_group_id = aws_security_group.this_sg[3].id
}


