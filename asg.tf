resource "aws_autoscaling_group" "dev-asg" {
  name                = "dev-asg"
  vpc_zone_identifier = [aws_subnet.dev-subnet-1.id, aws_subnet.dev-subnet-2.id, aws_subnet.dev-subnet-3.id]
  max_size            = 3
  min_size            = 3
  launch_template {
    id = aws_launch_template.dev_launch_template.id
  }
}
data "aws_ami" "asg-instance-ami" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "name"
    values = ["tomcat-server"]
  }
}
resource "aws_launch_template" "dev_launch_template" {
  name_prefix            = "dev-launch-template"
  image_id               = data.aws_ami.asg-instance-ami.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.asg_instance_sg.id]
}
resource "aws_security_group" "asg_instance_sg" {
  name   = "asg-instance-sg"
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "asg-instance-sg"
  }
}
resource "aws_security_group_rule" "instance_sg_allow_http" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.asg_instance_sg.id
}
resource "aws_security_group_rule" "instance_sg_allow_elb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  source_security_group_id = aws_security_group.elb_sg.id
  protocol                 = "-1"
  security_group_id        = aws_security_group.asg_instance_sg.id
}
