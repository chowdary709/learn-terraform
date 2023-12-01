# main.tf

variable "zone_id" {
  type    = string
  default = "Z08360431XA1BOY4SK2N0"
}

variable "record_name" {
  type    = string
  default = "roboshop.internal"
}

data "aws_route53_zone" "zone" {
  name = var.zone_id
}

data "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = var.record_name
  type    = "A"
}

# data.tf

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

data "aws_security_group" "sg" {
  name = "allow-all"
}
