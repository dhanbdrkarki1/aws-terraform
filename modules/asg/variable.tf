variable "image_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use"
  type        = string
  default     = "ami-0331ebbf81138e4de"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "web-test"
}



variable "max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "public_subnet_id1" {
  default = ""
}

variable "public_subnet_id2" {
  default = ""
}

variable "security_groups_name" {
  default = ""
  
}

variable "web_security_groups_id" {
  default = ""
}