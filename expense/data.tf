# data.aws_ami.ami.image_id

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

data "aws_security_group" "sg" {
  id = ["sg-0b792d7d432d8d378"]
}