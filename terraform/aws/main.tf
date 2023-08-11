provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# Instance WordPress
resource "aws_instance" "wp_instance" {
  ami                         = var.ami
  instance_type               = var.instance_micro
  subnet_id                   = aws_subnet.public_1a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = aws_key_pair.wp_key.key_name
  tags = {
    Name = "wp_instance"
  }
}

# Instance RDS
resource "aws_db_instance" "wp_db" {
  allocated_storage      = 10
  identifier             = "mysql-instance"
  engine                 = "mysql"
  engine_version         = "5.7.43"
  instance_class         = "db.t2.micro"
  db_name                = "wpdb"
  username               = "admin"
  password               = "12qwaszx"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.id
}
