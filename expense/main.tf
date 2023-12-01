#resource "aws_instance" "frontend" {
#  ami                    = data.aws_ami.ami.image_id
#  instance_type          = "t2.micro"
#  vpc_security_group_ids = [data.aws_security_group.sg.id]
#
#  tags = {
#    Name = "frontend"
#  }
#}
#
#resource "aws_route53_record" "frontend" {
#  name    = "frontend.roboshop.internal"
#  type    = "A"
#  zone_id = "Z08360431XA1BOY4SK2N0"
#  ttl = "5"
#  records = [ aws_instance.frontend.private_ip]
#}

resource "aws_instance" "frontend" {
  ami = data.aws_ami.ami.image_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.sg]

  tags = {
    Name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  name    = "frontend.roboshop.internal"
  type    = "A"
  zone_id = "Z08360431XA1BOY4SK2N0"
  ttl     = 5
  records = [aws_instance.frontend.private_ip]
}



