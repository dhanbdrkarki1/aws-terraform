output "web_security_groups_id" {
    value = aws_security_group.allow_web.id
}

output "web_security_groups_id_name" {
  value = aws_security_group.allow_web.name
}


output "database_security_groups_id" {
    value = aws_security_group.database_sg.id
}

output "alb_security_groups_id" {
    value = aws_security_group.load_balancer_sg.id
}

# output "efs_security_groups_id" {
#     value = aws_security_group.efs_sg.id
# }