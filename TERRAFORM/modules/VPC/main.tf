provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "this_main" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.VPC_NAME
  }
}

resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_main.id

  tags = {
    Name = var.IGW_NAME
  }
}

resource "aws_subnet" "this_public" {
  count                   = var.PUBLIC_SUBNET_COUNT
  vpc_id                  = aws_vpc.this_main.id
  cidr_block              = var.PUBLIC_SUBNET_CIDRS[count.index]
  availability_zone       = var.AVAILABILITY_ZONES[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "this_private_app" {
  count             = var.PRIVATE_APP_SUBNET_COUNT
  vpc_id            = aws_vpc.this_main.id
  cidr_block        = var.PRIVATE_APP_SUBNET_CIDRS[count.index]
  availability_zone = var.AVAILABILITY_ZONES[count.index]

  tags = {
    Name = "Private-App-${count.index + 1}"
  }
}



resource "aws_subnet" "this_private_db" {
  count             = var.PRIVATE_DB_SUBNET_COUNT
  vpc_id            = aws_vpc.this_main.id
  cidr_block        = var.PRIVATE_DB_SUBNET_CIDRS[count.index]
  availability_zone = var.AVAILABILITY_ZONES[count.index]

  tags = {
    Name = "Private-DB-${count.index + 1}"
  }
}


# elastic ip

resource "aws_eip" "this_eip" {
  domain = "vpc"

  tags = {
    Name = var.NAT_EIP_NAME
  }
}


# NGW

resource "aws_nat_gateway" "this_nat" {
  allocation_id = aws_eip.this_eip.id
  subnet_id     = aws_subnet.this_public[0].id

  depends_on = [
    aws_internet_gateway.this_igw
  ]

  tags = {
    Name = var.NAT_GW_NAME
  }
}

# Public-RT

resource "aws_route_table" "this_public" {
  vpc_id = aws_vpc.this_main.id

  route {
    cidr_block = var.PUBLIC_ROUTE_CIDR
    gateway_id = aws_internet_gateway.this_igw.id
  }

  tags = {
    Name = var.PUBLIC_RT_NAME
  }
}


# private -RT

resource "aws_route_table" "this_private" {
  vpc_id = aws_vpc.this_main.id

  route {
    cidr_block     = var.PRIVATE_ROUTE_CIDR
    nat_gateway_id = aws_nat_gateway.this_nat.id
  }

  tags = {
    Name = var.PRIVATE_RT_NAME
  }
}

# public-association

resource "aws_route_table_association" "this_public" {
  count          = length(aws_subnet.this_public)
  subnet_id      = aws_subnet.this_public[count.index].id
  route_table_id = aws_route_table.this_public.id
}

# private-association

resource "aws_route_table_association" "this_private_app" {
  count          = length(aws_subnet.this_private_app)
  subnet_id      = aws_subnet.this_private_app[count.index].id
  route_table_id = aws_route_table.this_private.id
}

# private-db

resource "aws_route_table_association" "this_private_db" {
  count          = length(aws_subnet.this_private_db)
  subnet_id      = aws_subnet.this_private_db[count.index].id
  route_table_id = aws_route_table.this_private.id
}










