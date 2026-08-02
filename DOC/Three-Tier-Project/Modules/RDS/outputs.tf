output "rds_endpoint" {
  value = aws_db_instance.RDS.endpoint
}

output "database_name" {
  value = aws_db_instance.RDS.db_name
}

output "database_port" {
  value = aws_db_instance.RDS.port
}

output "database_id" {
  value = aws_db_instance.RDS.id
}
