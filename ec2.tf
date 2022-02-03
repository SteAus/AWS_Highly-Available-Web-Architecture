resource "aws_instance" "poc-instance" {
  ami           = "ami-08895422b5f3aa64a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev-subnet-1.id
  tags = {
    Name = "poc-instance"
  }
}