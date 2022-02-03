resource "aws_autoscaling_group" "dev-asg"{
    name = "dev-asg"
    vpc_zone_identifier = [aws_subnet.dev-subnet-1.id]
    max_size = 3
    min_size = 1
    launch_template {
      id = aws_launch_template.dev-launch-template.id
    }
}
resource "aws_launch_template" "dev-launch-template" {
  name_prefix   = "dev-launch-template"
  image_id      = "ami-0a8b4cd432b1c3063"
  instance_type = "t2.micro"
}