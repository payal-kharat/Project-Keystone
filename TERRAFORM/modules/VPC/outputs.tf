output "vpc_id" {
  value = aws_vpc.this_main.id
}
output "public_subnet_ids" {
  value = aws_subnet.this_public[*].id
}
output "private_app_subnet_ids" {
  value = aws_subnet.this_private_app[*].id
}
output "private_db_subnet_ids" {
  value = aws_subnet.this_private_db[*].id
}
output "internet_gateway_id" {
  value = aws_internet_gateway.this_igw.id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.this_nat.id
}
