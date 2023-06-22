resource "aws_db_subnet_group" "blog" {
  name       = "blog"
  subnet_ids = [var.private_subnet1, var.private_subnet2]

  tags = {
    Name = "Blog"
  }
}


resource "aws_db_parameter_group" "blog" {
  name   = "blog"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "blog" {
  identifier             = var.identifier
  instance_class         = var.instance_class
  allocated_storage      = var.db_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  username               = "dhan"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.blog.name
  vpc_security_group_ids = [var.database_security_groups_id]
  parameter_group_name   = aws_db_parameter_group.blog.name
  
  # publicly_accessible    = true
  skip_final_snapshot    = true

  tags = {
    Name = "blog_postgres"
  }
}


