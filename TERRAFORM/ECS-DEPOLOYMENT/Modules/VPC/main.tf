
# VPC

resource "aws_vpc" "THIS_VPC" {

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}
# Internet Gateway

resource "aws_internet_gateway" "THIS_IGW" {

  vpc_id = aws_vpc.THIS_VPC.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Elastic IP

resource "aws_eip" "nat" {

  domain = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}


# Public Subnets

resource "aws_subnet" "public" {

  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.THIS_VPC.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${count.index + 1}"
  }
}


# Private App Subnets


resource "aws_subnet" "private_app" {

  count = length(var.private_app_subnets)

  vpc_id            = aws_vpc.THIS_VPC.id
  cidr_block        = var.private_app_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project_name}-private-app-${count.index + 1}"
  }
}


# Private DB Subnets


resource "aws_subnet" "private_db" {

  count = length(var.private_db_subnets)

  vpc_id            = aws_vpc.THIS_VPC.id
  cidr_block        = var.private_db_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project_name}-private-db-${count.index + 1}"
  }
}


# NAT Gateway

resource "aws_nat_gateway" "THIS_NAT_GW" {

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.THIS_IGW
  ]

  tags = {
    Name = "${var.project_name}-nat"
  }
}


# Public Route Table


resource "aws_route_table" "public" {

  vpc_id = aws_vpc.THIS_VPC.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.THIS_IGW.id

  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}


# Private Route Table


resource "aws_route_table" "private" {

  vpc_id = aws_vpc.THIS_VPC.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.THIS_NAT_GW.id

  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}


# Public Route Table Association


resource "aws_route_table_association" "public" {

  count = length(var.public_subnets)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}


# Private App Route Association

resource "aws_route_table_association" "private_app" {

  count = length(var.private_app_subnets)

  subnet_id = aws_subnet.private_app[count.index].id

  route_table_id = aws_route_table.private.id
}


# Private DB Route Association

resource "aws_route_table_association" "private_db" {

  count = length(var.private_db_subnets)

  subnet_id = aws_subnet.private_db[count.index].id

  route_table_id = aws_route_table.private.id
}