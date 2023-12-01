# ec2.tf

resource "aws_instance" "example" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  security_group = [data.aws_security_group.sg.id]

  tags = {
    Name = "example-instance"
  }
}
# route53.tf

resource "aws_route53_record" "instance_record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "frontend.${data.aws_route53_zone.zone.name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.example.private_ip]
}
