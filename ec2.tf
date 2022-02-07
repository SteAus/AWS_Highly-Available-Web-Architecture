resource "aws_instance" "poc-instance" {
  ami             = "ami-0a8b4cd432b1c3063"
  security_groups = [aws_security_group.asg_instance_sg.id]
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.dev-subnet-1.id
  tags = {
    Name = "poc-instance"
  }
}
