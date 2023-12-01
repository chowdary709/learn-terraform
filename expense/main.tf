data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

data "aws_security_group" "sg" {
  name = "allow-all"
}

data "aws_route53_zone" "zone" {
  name = var.zone_id
}
variable "zone_id" {
  default = "Z08360431XA1BOY4SK2N0"
}

locals {
  ami     = data.aws_ami.ami.image_id
  zone_id = data.aws_route53_zone.zone.zone_id
}

resource "aws_instance" "frontend" {
  ami                    = local.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = local.zone_id
  name    = "frontend.${var.zone_id}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}
