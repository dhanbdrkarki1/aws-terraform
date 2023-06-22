output "domain_name" {
  value = var.domain_name
}

# output "certificate_arn" {
#     value = aws_acm_certificate.acm_certificate.arn
# }

output "ssl_certificate_arn" {
    value = aws_acm_certificate_validation.acm_certificate_validation.certificate_arn
}