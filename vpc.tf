resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}
resource "aws_subnet" "dev-subnet-1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "dev-subnet-1"
  }
}
resource "aws_subnet" "dev-subnet-2" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "dev-subnet-2"
  }
}
resource "aws_subnet" "dev-subnet-3" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "dev-subnet-3"
  }
}
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.4.0/28"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "private-subnet-1"
  }
}
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.5.0/28"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "private-subnet-2"
  }
}
resource "aws_subnet" "private-subnet-3" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.6.0/28"
  availability_zone       = "us-east-1c"
  tags = {
    Name = "private-subnet-3"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-vpc.id
}
resource "aws_default_route_table" "dev-vpc-rt" {
  default_route_table_id = aws_vpc.dev-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    name = "dev-vpc-rt"
  }
}
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.dev-vpc.id
}
resource "aws_route_table_association" "private-subnet-1-association"{
  subnet_id = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "private-subnet-2-association"{
  subnet_id = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "private-subnet-3-association"{
  subnet_id = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-rt.id
}
