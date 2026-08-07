output "instance_id" {
  value = aws_instance.this_app_server.id
}

output "private_ip" {
  value = aws_instance.this_app_server.private_ip
}
