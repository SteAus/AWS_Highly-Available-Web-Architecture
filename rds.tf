resource "aws_db_instance" "dev_rds" {
  allocated_storage       = 10
  apply_immediately       = true
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  name                    = "rdsdev"
  username                = "devuser"
  password                = "devuseradmin"
  parameter_group_name    = "default.mysql8.0"
  option_group_name       = "default:mysql-8-0"
  multi_az                = "true"
  availability_zone       = aws_subnet.private-subnet-1.availability_zone
  backup_retention_period = 1
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.dev_rds_subnet_group.name
}
resource "aws_db_instance" "dev_rds_replica" {
  allocated_storage       = 10
  apply_immediately       = true
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  name                    = "rdsdev"
  username                = "devuser"
  password                = "devuseradmin"
  parameter_group_name    = "default.mysql8.0"
  option_group_name       = "default:mysql-8-0"
  multi_az                = "false"
  availability_zone       = aws_subnet.private-subnet-2.availability_zone
  backup_retention_period = 1
  replicate_source_db     = aws_db_instance.dev_rds.identifier

  skip_final_snapshot = true
  #db_subnet_group_name = aws_db_subnet_group.dev_rds_subnet_group.name
}
resource "aws_db_subnet_group" "dev_rds_subnet_group" {
  name       = "dev-rds-subnet-group"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]
  tags = {
    Name = "rds-subnet-group"
  }
}
resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "asg-instance-sg"
  }
}
resource "aws_security_group_rule" "rds_sg_allow_ec2" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 3306
  source_security_group_id = aws_security_group.asg_instance_sg.id
  protocol                 = "-1"
  security_group_id        = aws_security_group.rds_sg.id
}
