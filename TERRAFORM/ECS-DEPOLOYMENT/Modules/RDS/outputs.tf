output "db_endpoint" {
  value = aws_db_instance.this_db_instance.endpoint
}

output "db_address" {
  value = aws_db_instance.this_db_instance.address
}

output "db_name" {
  value = aws_db_instance.this_db_instance.db_name
}

output "db_port" {
  value = aws_db_instance.this_db_instance.port
}

output "db_instance_id" {
  value = aws_db_instance.this_db_instance.id
}