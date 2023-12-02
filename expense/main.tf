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
  name    = "frontend.${var.zone_name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}



output "zone_id" {
  value = data.aws_route53_zone.zone.id
}