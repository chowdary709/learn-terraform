resource "aws_instance" "frontend" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg_id
  tags = {
    Name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = var.zone_id
  name    = "frontend.${var.Hosted_zone_name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}