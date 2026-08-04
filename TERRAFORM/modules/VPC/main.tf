provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_subnet" "public" {
  count = var.public_subnet_count
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "private_app" {
  count = var.private_app_subnet_count
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Private-App-${count.index + 1}"
  }
}



resource "aws_subnet" "private_db" {
  count = var.private_db_subnet_count
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_db_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Private-DB-${count.index + 1}"
  }
}


# elastic ip

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = var.nat_eip_name
  }
}


# NGW

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    Name = var.nat_gw_name
  }
}

# Public-RT

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.public_route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_RT_name
  }
}


# private -RT

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.private_route_cidr
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = var.private_RT_name
  }
}

# public-association

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# private-association

resource "aws_route_table_association" "private_app" {
  count = length(aws_subnet.private_app)
  subnet_id = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private.id
}

# private-db

resource "aws_route_table_association" "private_db" {
  count = length(aws_subnet.private_db)
  subnet_id = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private.id
}


 







