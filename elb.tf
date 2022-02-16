resource "aws_elb" "elb" {
  name            = "elb"
  subnets         = [aws_subnet.dev-subnet-1.id, aws_subnet.dev-subnet-2.id, aws_subnet.dev-subnet-3.id]
  security_groups = [aws_security_group.elb_sg.id]
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    target              = "TCP:111"
    interval            = 10
    timeout             = 5
  }
  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.acm-cert.id
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
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.elb_sg.id
}
resource "aws_security_group_rule" "elb_sg_allow_tcp" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.asg_instance_sg.id
  protocol                 = "tcp"
  security_group_id        = aws_security_group.elb_sg.id
}
resource "aws_autoscaling_attachment" "asg_lb" {
  autoscaling_group_name = aws_autoscaling_group.dev-asg.name
  elb                    = aws_elb.elb.id
}
