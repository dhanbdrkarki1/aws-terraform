# Security Groups
module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "./modules/vpc"
  # web_security_groups_id = module.sg.web_security_groups_id.id
}


module "key-pair" {
  source       = "./modules/key-pair"
  key_name     = "web-test"
  key_filename = "web-test-2.pem"
}

# Elastic Cloud Compute
module "ec2" {
  source                 = "./modules/ec2"
  vpc_id                 = module.vpc.vpc_id
  public_subnet1         = module.vpc.public_subnet1
  public_subnet2         = module.vpc.public_subnet2
  private_subnet1        = module.vpc.private_subnet1
  private_subnet2        = module.vpc.private_subnet2
  web_security_groups_id = module.sg.web_security_groups_id
}


#Elastic File Sharing
# module "efs" {
#   source                 = "./modules/efs"
#   efs_name               = "my_efs"
#   subnet_id              = module.vpc.public_subnet1
#   efs_security_groups_id = module.sg.efs_security_groups_id

#   # mounting in instance
#   user        = "ec2-user"
#   private_key = module.key-pair.private_key
#   host        = module.ec2.web_server_1_public_ip

# }


# Relational Database System
module "rds" {
  source                      = "./modules/rds"
  private_subnet1             = module.vpc.private_subnet1
  private_subnet2             = module.vpc.private_subnet2
  vpc_id                      = module.vpc.vpc_id
  database_security_groups_id = module.sg.database_security_groups_id

}




# Auto Scaling Groups
module "asg" {
  source                 = "./modules/asg"
  public_subnet_id1      = module.vpc.public_subnet1
  public_subnet_id2      = module.vpc.public_subnet2
  security_groups_name   = module.sg.web_security_groups_id_name
  web_security_groups_id = module.sg.web_security_groups_id
}



# Load Balancer
module "alb" {
  source                = "./modules/alb"
  lb_security_groups_id = module.sg.alb_security_groups_id
  vpc_id                = module.vpc.vpc_id
  web_server_1          = module.ec2.web_server_1
  web_server_2          = module.ec2.web_server_2
  public_subnet1        = module.vpc.public_subnet1
  public_subnet2        = module.vpc.public_subnet2
  # ssl_certificate_arn = module.alb.certificate_arn
}

# Route 53
# module "route53" {
#   source                 = "./modules/route53"
#   domain_name            = var.domain_name
#   tag_name               = "Dev"
#   load_balancer_dns_name = module.alb.load_balancer_dns_name
#   load_balancer_zone_id  = module.alb.load_balancer_zone_id
# }

# SSL Certificate
# module "acm" {
#   source           = "./modules/acm"
#   domain_name      = var.domain_name
#   alternative_name = var.alternative_name
#   route53_zone_id  = module.route53.route53_zone_id

# }
