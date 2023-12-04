resource "aws_instance" "instance" {
  ami                    = local.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Name = var.component
  }
}

resource "aws_route53_record" "record" {
  zone_id = local.zone_id
  name    = "${var.component}.${var.zone_name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}


resource "null_resource" "ansible" {
  depends_on = [aws_route53_record]

  provisioner "local-exec" {
    command = <<EOF
cd /root/expense-ansible/roles
git pull
sleep 60
ansible-playbook -i ${aws_instance.instance.private_ip}, -e ansible_user=centos -e ansible_password=DevOps321 expense.yml -e role_name=${var.component}
EOF
  }
}