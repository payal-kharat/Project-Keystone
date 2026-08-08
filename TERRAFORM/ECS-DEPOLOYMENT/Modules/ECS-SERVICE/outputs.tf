output "service_name" {
  value = aws_ecs_service.this_ecs_service.name
}

output "service_arn" {
  value = aws_ecs_service.this_ecs_service.id
}