# Web Server 1
resource "aws_instance" "web_server_1" {
  ami               = var.ami # us-west-2
  instance_type     = var.type
  availability_zone = var.az1
  key_name          = var.key_pair
  associate_public_ip_address = true
  subnet_id = var.public_subnet1
  vpc_security_group_ids = [var.web_security_groups_id]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo bash -c 'echo "This is the first web server." > /var/www/html/index.html'
            EOF
  tags = {
    Name = "web_server_1"
  }
}

# Web Server 2
resource "aws_instance" "web_server_2" {
  ami               = var.ami # us-west-2
  instance_type     = var.type
  availability_zone = var.az2
  key_name          = var.key_pair
  associate_public_ip_address = true
  subnet_id = var.public_subnet2
  vpc_security_group_ids = [var.web_security_groups_id]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo bash -c 'echo "This is the first web server." > /var/www/html/index.html'
          EOF
  tags = {
    Name = "web_server_2"
  }
}

# Jenkins Server
resource "aws_instance" "jenkins-server" {
  ami               = var.ami # us-west-2
  instance_type     = var.type
  availability_zone = var.az1
  key_name          = var.key_pair
  associate_public_ip_address = true
  subnet_id = var.private_subnet1
  vpc_security_group_ids = [var.web_security_groups_id]
  tags = {
    Name = "jenkins-server"
  }
}




# Database Server
resource "aws_instance" "database-server" {
  ami               = var.ami # us-west-2
  instance_type     = var.type
  availability_zone = var.az2
  key_name          = var.key_pair
  associate_public_ip_address = true
  subnet_id = var.private_subnet2
  vpc_security_group_ids = [var.web_security_groups_id]
  tags = {
    Name = "database-server"
  }
}





