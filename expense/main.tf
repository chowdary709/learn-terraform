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


resource "null_resource" "frontend" {
  depends_on = [aws_route53_record.frontend]
  provisioner "local-exec" {
    command = <<EOF
git clone https://github.com/chowdary709/infra-ansible.git
git pull
cd /root/infra-ansible/roles
git pull
sleep 70
ansible-playbook -i  ${aws_instance.frontend.private_ip}, -e role_name=frontend expense.yml
EOF
  }
}
# ansible-playbook -i  ${aws_instance.frontend.private_ip}, -e role_name=frontend expense.yml
