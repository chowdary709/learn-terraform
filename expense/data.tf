

# Define AWS AMI
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

# Define AWS Security Group
data "aws_security_group" "sg" {
  name = "allow-all"
}

# Define Route 53 Zone
variable "zone_id" {
  type    = string
  default = "Z08360431XA1BOY4SK2N0"
}

data "aws_route53_zone" "zone" {
  name = var.zone_id
}

# Define Route 53 Record
variable "record_name" {
  type    = string
  default = "roboshop.internal"
}

