
resource "aws_vpc" "this_vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}
# Internet Gateway

resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_vpc.id
  tags = {
    Name = "${var.PROJECT_NAME}-igw"
  }
}

# Elastic IP

resource "aws_eip" "this_nat" {
  domain = "vpc"
  tags = {
    Name = "${var.PROJECT_NAME}-eip"
  }
}


# Public Subnets

resource "aws_subnet" "this_public_subnet" {
  count                   = length(var.PUBLIC_SUBNETS)
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.PUBLIC_SUBNETS[count.index]
  availability_zone       = var.AVAILABILITY_ZONES[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.PROJECT_NAME}-public-${count.index + 1}"
  }
}


# Private App Subnets


resource "aws_subnet" "this_private_app_subnet" {
  count             = length(var.PRIVATE_APP_SUBNETS)
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = var.PRIVATE_APP_SUBNETS[count.index]
  availability_zone = var.AVAILABILITY_ZONES[count.index]
  tags = {
    Name = "${var.PROJECT_NAME}-private-app-${count.index + 1}"
  }
}


# Private DB Subnets


resource "aws_subnet" "this_private_db_subnet" {
  count             = length(var.PRIVATE_DB_SUBNETS)
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = var.PRIVATE_DB_SUBNETS[count.index]
  availability_zone = var.AVAILABILITY_ZONES[count.index]
  tags = {
    Name = "${var.PROJECT_NAME}-private-db-${count.index + 1}"
  }
}


# NAT Gateway

resource "aws_nat_gateway" "this_nat_gw" {
  allocation_id = aws_eip.this_nat.id
  subnet_id     = aws_subnet.this_public_subnet[0].id
  depends_on = [
    aws_internet_gateway.this_igw
  ]
  tags = {
    Name = "${var.PROJECT_NAME}-nat"
  }
}


# Public Route Table


resource "aws_route_table" "this_public_rt" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this_igw.id
  }
  tags = {
    Name = "${var.PROJECT_NAME}-public-rt"
  }
}


# Private Route Table


resource "aws_route_table" "this_private_rt" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this_nat_gw.id
  }
  tags = {
    Name = "${var.PROJECT_NAME}-private-rt"
  }
}


# Public Route Table Association


resource "aws_route_table_association" "this_public_association" {
  count          = length(var.PUBLIC_SUBNETS)
  subnet_id      = aws_subnet.this_public_subnet[count.index].id
  route_table_id = aws_route_table.this_public_rt.id
}


# Private App Route Association

resource "aws_route_table_association" "this_private_app_association" {
  count          = length(var.PRIVATE_APP_SUBNETS)
  subnet_id      = aws_subnet.this_private_app_subnet[count.index].id
  route_table_id = aws_route_table.this_private_rt.id
}


# Private DB Route Association

resource "aws_route_table_association" "this_private_db_association" {
  count          = length(var.PRIVATE_DB_SUBNETS)
  subnet_id      = aws_subnet.this_private_db_subnet[count.index].id
  route_table_id = aws_route_table.this_private_rt.id
}