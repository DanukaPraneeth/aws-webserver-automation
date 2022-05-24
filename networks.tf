resource "aws_vpc" "primary_vpc" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_hostnames = true

  tags = {
    Name = "My VPC"
  }
}


resource "aws_subnet" "public_subnet_az_1" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.cidr_block_public_subnet_1
  availability_zone = var.az_1

  tags = {
    Name = "Public Subnet az 1"
  }
}

resource "aws_subnet" "public_subnet_az_2" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.cidr_block_public_subnet_2
  availability_zone = var.az_2

  tags = {
    Name = "Public Subnet az 2"
  }
}

resource "aws_subnet" "private_subnet_az_1" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.cidr_block_private_subnet_1
  availability_zone = var.az_1

  tags = {
    Name = "Private Subnet az 1"
  }
}

resource "aws_subnet" "private_subnet_az_2" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.cidr_block_private_subnet_2
  availability_zone = var.az_2

  tags = {
    Name = "Private Subnet az 2"
  }
}
