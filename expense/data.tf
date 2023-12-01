data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

data "aws_security_group" "sg" {
  name = "allow-all"
}

variable "zone_id" {
  type    = string
  default = "Z08360431XA1BOY4SK2N0"
}
data "aws_route53_zone" "zone" {
  name = var.zone_id
}

variable "record_name" {
  default = "roboshop.internal"
}

