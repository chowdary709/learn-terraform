resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "frontend.roboshop.internal"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}
