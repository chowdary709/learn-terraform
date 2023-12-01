data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

data "aws_security_group" "sg" {
  name = "allow-all"
}


# Use a single data block for aws_route53_zone
data "aws_route53_zone" "zone" {
  name = "Z08360431XA1BOY4SK2N0"
}


locals {
  ami     = data.aws_ami.ami.image_id
#  zone_id = data.aws_route53_zone.zone.zone_id
}
