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
}
resource "aws_security_group" "elb_sg" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "elb-sg"
  }
}
resource "aws_security_group_rule" "elb_sg_allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.elb_sg.id
}
resource "aws_autoscaling_attachment" "asg_lb" {
  autoscaling_group_name = aws_autoscaling_group.dev-asg.name
  elb = aws_elb.elb.id
}