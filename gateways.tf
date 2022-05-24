resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.primary_vpc.id

  tags = {
    Name = "My VPC - Internet Gateway"
  }
}


resource "aws_eip" "nat_gw_eip" {
  vpc = true
}


resource "aws_nat_gateway" "vpc_nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet_az_1.id
}
