resource "aws_lb" "web-load-balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security_groups_id]
  subnets            = [var.public_subnet1, var.public_subnet2]
  enable_deletion_protection = false


  tags = {
    Environment = "dev"
  }
}

# Instance target Group
resource "aws_lb_target_group" "web-lb-tg" {
  name     = var.alb_target_group
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Register second instances with ALB
resource "aws_lb_target_group_attachment" "web-load-balancer1" {
  target_group_arn = aws_lb_target_group.web-lb-tg.arn
  target_id        = var.web_server_1
  port             = 80
}

# Register second instances with ALB
resource "aws_lb_target_group_attachment" "web-load-balancer2" {
  target_group_arn = aws_lb_target_group.web-lb-tg.arn
  target_id        = var.web_server_2
  port             = 80
}


# Providing a Load Balancer Listener resource
resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.web-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  # default_action {
  #   type             = "forward"
  #   target_group_arn = aws_lb_target_group.web-lb-tg.arn
  # }

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Note: if http, also redirect to http