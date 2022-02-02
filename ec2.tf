provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAYJZIJVLFES7VXNUA"
  secret_key = "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"
}
resource "aws_instance" "dev-server" {
  ami           = "ami-0a8b4cd432b1c3063"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.dev-subnet-1.id
  tags = {
    Name = "Micro"
  }
}
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
resource "aws_security_group" "elb_sg" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "elb-sg"
  }
}
resource "aws_security_group_rule" "elb_sg_allow_http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    security_group_id = aws_security_group.elb_sg.id
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-vpc.id
}
resource "aws_elb" "elb" {
  name            = "elb"
  subnets         = [aws_subnet.dev-subnet-1.id]
  security_groups = [aws_security_group.elb_sg.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  instances = [aws_instance.dev-server.id]
}
