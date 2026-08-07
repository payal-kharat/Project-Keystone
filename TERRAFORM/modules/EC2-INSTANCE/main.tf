resource "aws_instance" "this_app_server" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  subnet_id     = var.SUBNET_ID
  key_name      = var.KEY_NAME
  vpc_security_group_ids = [
    var.SECURITY_GROUP_ID
  ]
  associate_public_ip_address = var.ASSOCIATE_PUBLIC_IP
  user_data                   = file("${path.module}/userdata.sh")
  tags = {
    Name = var.INSTANCE_NAME
  }
}


# TG aatachement

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = var.TARGATE_GROUP_ARN
  count            = var.ATTACH_TO_TARGATE_GROUP ? 1 : 0
  target_id        = aws_instance.this_app_server.id
  port             = 80
}


