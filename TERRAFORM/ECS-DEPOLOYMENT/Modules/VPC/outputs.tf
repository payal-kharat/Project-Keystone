output "vpc_id" {

  value = aws_vpc.THIS_VPC.id

}

output "public_subnet_ids" {

  value = aws_subnet.public[*].id

}

output "private_app_subnet_ids" {

  value = aws_subnet.private_app[*].id

}

output "private_db_subnet_ids" {

  value = aws_subnet.private_db[*].id

}

output "internet_gateway_id" {

  value = aws_internet_gateway.THIS_IGW.id

}

output "nat_gateway_id" {

  value = aws_nat_gateway.THIS_NAT_GW.id

}