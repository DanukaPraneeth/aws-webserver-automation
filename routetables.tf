# Route table for the public subnet

resource "aws_route_table" "vpc_public_subnet_route" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "Public Subnets Route Table for My VPC"
  }
}

resource "aws_route_table_association" "public_subnet_1_route" {
  subnet_id      = aws_subnet.public_subnet_az_1.id
  route_table_id = aws_route_table.vpc_public_subnet_route.id
}

resource "aws_route_table_association" "public_subnet_2_route" {
  subnet_id      = aws_subnet.public_subnet_az_2.id
  route_table_id = aws_route_table.vpc_public_subnet_route.id
}



# Route table for the private subnet

resource "aws_route_table" "nated_private_subnet_route" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc_nat_gw.id
  }

  tags = {
    Name = "Main Route Table for NAT-ed subnet"
  }
}

resource "aws_route_table_association" "private_az_1_to_nat" {
  subnet_id      = aws_subnet.private_subnet_az_1.id
  route_table_id = aws_route_table.nated_private_subnet_route.id
}

resource "aws_route_table_association" "private_az_2_to_nat" {
  subnet_id      = aws_subnet.private_subnet_az_2.id
  route_table_id = aws_route_table.nated_private_subnet_route.id
}
