# creating EFS File System
resource "aws_efs_file_system" "my_efs" {
  creation_token = var.efs_name
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  encrypted = "true"
#   depends_on = [  ]

  tags = {
    Name = var.efs_name
  }
}

# Creating mount target of EFS
resource "aws_efs_mount_target" "efs_mount" {    
  # mounting to all azs
#   count = length(data.aws_availability_zones.available.names)
  file_system_id = aws_efs_file_system.my_efs.id
  subnet_id      = var.subnet_id
  security_groups = [var.efs_security_groups_id]
}

# Attaching created EFS to EC2 Instance
resource "null_resource" "configure_nfs" {
  depends_on = [ aws_efs_mount_target.efs_mount ]
  connection {
    type = "ssh"
    user = var.user
    private_key = var.private_key
    host = var.host
    timeout = "20s"
  }

  provisioner "remote-exec" {
    inline = [
        "sudo yum install httpd  php git -y",
        "sudo systemctl restart httpd",
        "sudo systemctl enable httpd",
        "sudo yum install -y amazon-efs-utils",
        "sudo echo ${aws_efs_file_system.my_efs.dns_name}:/var/www/html efs defaults,_netdev 0 0 >> sudo /etc/fstab",
        "sudo mount -t nfs4  ${aws_efs_file_system.my_efs.dns_name}:/  /var/www/html",
        "sudo rm -rf /var/www/html/*",
        "sudo git clone https://github.com/Priyanshi541/HTask2.git /var/www/html/",
    ]
  }
}