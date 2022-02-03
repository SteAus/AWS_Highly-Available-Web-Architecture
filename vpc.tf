resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}
resource "aws_subnet" "dev-subnet-1" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "dev-subnet-1"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-vpc.id
}
