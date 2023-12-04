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
  depends_on = [aws_route53_record.record]


  provisioner "local-exec" {
    command = <<EOF
cd /root/expense-ansible/roles
git pull
sleep 60
ansible-playbook -i ${aws_instance.instance.private_ip}, -e ansible_user=centos -e ansible_password=DevOps321 expense.yml -e role_name=${var.component}
EOF
  }
}

#╷
#│ Error: creating Route 53 Record: InvalidChangeBatch: [Tried to create resource record set [name='mysql.roboshop.internal.', type='A'] but it already exists]
#│       status code: 400, request id: e076580c-26fb-4c7f-8a67-66e55474d904
#│
#│   with module.expense[1].aws_route53_record.record,
#│   on module/main.tf line 11, in resource "aws_route53_record" "record":
#│   11: resource "aws_route53_record" "record" {
#│
#╵
#╷
#│ Error: creating Route 53 Record: InvalidChangeBatch: [Tried to create resource record set [name='backend.roboshop.internal.', type='A'] but it already exists]
#│       status code: 400, request id: e75fca39-8c1a-4bc1-8d93-6e56b90b30dd
#│
#│   with module.expense[2].aws_route53_record.record,
#│   on module/main.tf line 11, in resource "aws_route53_record" "record":
#│   11: resource "aws_route53_record" "record" {