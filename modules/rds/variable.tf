variable "identifier" {
    type = string
    default = "blog"
    description = "Name of your DB cluster"
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
  description = "type of storage class"
}

variable "db_storage" {
    type = number
    default = "10"
}

variable "engine" {
    type = string
    default = "postgres"
    description = "Name of database engine"
}

variable "engine_version" {
    type = number
    default = "14.7"
}



#  export TF_VAR_db_password="*******"
variable "db_password" {
  description = "RDS root user password"
  type        = string
  default = "Password0123"
  sensitive   = true
}

variable "private_subnet1" {

}

variable "private_subnet2" {

}


variable "vpc_id" {
  
}

variable "database_security_groups_id" {
  
}