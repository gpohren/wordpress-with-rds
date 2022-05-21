# VPC
resource "aws_vpc" "vpc_wp" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_wp"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_wp.id
  tags = {
    Name = "igw"
  }
}

# Subnet public 1a
resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.vpc_wp.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public_1a"
  }
}

# Subnet public 1b
resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.vpc_wp.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "public_1b"
  }
}

# Route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_wp.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}

# Associate public 1a to public route table
resource "aws_route_table_association" "public_1a_association" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate public 1b to public route table
resource "aws_route_table_association" "public_1b_association" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public_route_table.id
}

# Subnet private 1a
resource "aws_subnet" "private_1a" {
  vpc_id                  = aws_vpc.vpc_wp.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  tags = {
    Name = "private_1a"
  }
}

# Subnet private 1b
resource "aws_subnet" "private_1b" {
  vpc_id                  = aws_vpc.vpc_wp.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  tags = {
    Name = "private_1b"
  }
}

# Subnet Amazon RDS
resource "aws_db_subnet_group" "db_subnet" {
  name       = "dbsubnet"
  subnet_ids = [aws_subnet.private_1a.id, aws_subnet.private_1b.id]
}
