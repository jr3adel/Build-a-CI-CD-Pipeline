
# Create AWS RDS MYSQL
resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.inst_class
  name                 = "mydb"
  username             = var.user_name
  password             = var.pass
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  skip_final_snapshot = true

    tags = {
    Name = "Our RDS MYSQL Database "
  }
}

