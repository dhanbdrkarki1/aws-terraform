# web traffic security groups
# Security Group to allow port 22, 80, 443
resource "aws_security_group" "allow_web" {
  name        = var.web_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSHrom VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

# querying web server security group
# data "aws_security_group" "allow_web" {
#   name = aws_security_group.allow_web.name
# }

# database security groups
resource "aws_security_group" "database_sg" {
  name = var.db_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id = var.vpc_id


  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_web.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.allow_web.id]
  }

  tags = {
    Name = "db-sg"
  }

}



# load balancer security groups
# Security Group to allow port 22, 80, 443
resource "aws_security_group" "load_balancer_sg" {
  name        = var.lb_sg_name
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-load-balancer"
  }
}


# Accessing EFS File System
# database security groups
resource "aws_security_group" "efs_sg" {
  name = var.efs_sg_name
  description = "Inbound NFS access from EFS clients"
  vpc_id = var.vpc_id


  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["0.0.0.0/0"]
  }

  tags = {
    Name = "efs-sg"
  }

}