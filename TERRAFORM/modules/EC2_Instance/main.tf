resource "aws_instance" "app_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = var.key_name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  associate_public_ip_address = var.associate_public_ip
  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = var.instance_name
  }
}


# TG aatachement

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = var.target_group_arn
  count = var.attach_to_target_group ? 1 : 0
  target_id = aws_instance.app_server.id
  port = 80
}


