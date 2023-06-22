# managing domain using load balancer as alias records

# as per video
# resource "aws_route53_zone" "hosted_zone" {
#   name = var.domain_name
# }

resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
  comment = "Web Server domain name for demo"

  tags = {
    Environment = var.tag_name
  }
}


# simple routing policy
resource "aws_route53_record" "www_domain" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = var.www_sub_domain
  type    = "A"
  # ttl     = 300
  #   records = [aws_eip.lb.public_ip]

  alias {
    name                   = var.load_balancer_dns_name
    zone_id                = var.load_balancer_zone_id
    evaluate_target_health = true
  }
}


# ssl certificate
# domain name
# validation method - dns validation
# create record in route 53

# in load balancer
# add listener
# listener ID: Https:443
# action: forward
# target group: instance, ipv4
# default ssl certificate: your domain from ACM


# Also in listener port 80, remove its forward to rule and add action and redirect to 443.
# for www, create new record. 