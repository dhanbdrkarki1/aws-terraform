output "web_server_1" {
    value = aws_instance.web_server_1.id
}

output "web_server_1_public_ip" {
  value = aws_instance.web_server_1.public_ip
}

output "web_server_2" {
    value = aws_instance.web_server_2.id
}

output "web_server_2_public_ip" {
  value = aws_instance.web_server_2.public_ip
}
