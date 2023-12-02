resource "aws_instance" "frontend" {
  ami                    = local.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Name = "frontend"
  }
  provisioner "local-exec" {
    command = <<EOF
cd /root/infra-ansible/roles
git pull
sleep 60
/path/to/ansible-playbook -i ${aws_instance.frontend.private_ip}, expense.yml -e role_name=frontend
EOF
  }

}

resource "aws_route53_record" "frontend" {
  zone_id = local.zone_id
  name    = "frontend.${var.zone_name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}
