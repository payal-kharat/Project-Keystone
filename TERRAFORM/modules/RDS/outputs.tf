output "rds_endpoint" {
  value = aws_db_instance.this_rds_instance.endpoint
}

output "database_name" {
  value = aws_db_instance.this_rds_instance.db_name
}

output "database_port" {
  value = aws_db_instance.this_rds_instance.port
}

output "database_id" {
  value = aws_db_instance.this_rds_instance.id
}
