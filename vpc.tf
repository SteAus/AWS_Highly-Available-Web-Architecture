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
