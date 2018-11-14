
resource "aws_key_pair" "dev-key" {
  key_name   = "${var.owner}-key"
  public_key = "${file("${var.public-key-location}")}"
  #"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6YuG9VaOOcXqsCvoLYtxn91iTUw9EQ3Bz/F4WQD0SlFb9TkEwx1NTmK8lblrJdb5Qtc+CndsJaCRvsyu5k/27Esz9+VuJI5gxWQIr2DKGGFUim2Ysp5ypHzFJqZUfqJPigwHZ2b5scl3ZiNArhzbAIG7TZHsFg3DITSc4/zrB3K8nF/wGLOhoeuYVCDYxVGZKwISZIrvEQAaFAGmNBxPkjsYnKkd2DuXUwE1SPllr7Eu7dibjL2Tw+6UrKQC89a0DjWsbANwXJzoz796hLwm5kLYNCl0HS3iM0XjeckcULYeRtHu5UrY7sMwYiXwlJRouEqNYLTXwFgAswlZHuyF9 kevin@kking-lt3"
}

resource "aws_instance" "apics-node-1" {
  ami           = "${var.ami}" #"ami-0ad99772"
  instance_type = "${var.instance-type}" #"m5.large"
  subnet_id = "${var.public-a}"
  key_name = "${aws_key_pair.dev-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.apics-node.id}"]
  user_data = "${file("configure/userdata.sh")}"

  tags {
    Name = "${var.instance-name} - 1"
    Owner = "${var.owner}"
  }

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > configure/aws_hosts1
# This is a generated file.
[dev]
${aws_instance.apics-node-1.public_ip}

[dev:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
EOD
  }

  # install Java
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.apics-node-1.id} && ansible-playbook -i configure/aws_hosts1 configure/playbook-install-jdk8.yml"
  }

  # build gateway-props.json file...
  provisioner "file" {
    content = <<EOD
{
   "nodeInstallDir"           : "/opt/oracle/gateway",
   "logicalGateway"           : "${var.logical-gateway}",
   "logicalGatewayId"         : "${var.logical-gateway-id}",
   "gatewayNodeName"          : "${var.logical-gateway}-node-1",
   "managementServiceUrl"     : "${var.management-service-url}",
   "listenIpAddress"          : "${aws_instance.apics-node-1.private_ip}",
   "publishAddress"           : "${aws_lb.apics-lb.dns_name}",
   "gatewayExecutionMode"     : "${var.gateway-execution-mode}",
   "idcsUrl"                  : "${var.idcs-url}",
   "requestScope"             : "${var.request-scope}",
   "prevInstallCleanupAction" : "clean"
}
EOD
    destination = "/home/ec2-user/local-gateway-props.json"
    connection {
      type = "ssh"
      user = "ec2-user"
    }
  }

  # install apics gateway
  provisioner "local-exec" {
    #command = "ansible-playbook -i configure/aws_hosts1 configure/playbook-install-configure-join-apicsgatewaynode.yml"
    command = "ansible-playbook -i configure/aws_hosts1 configure/playbook-install-configure-join-apicsgatewaynode.yml --extra-vars 'gatewayuser=${var.gateway-user} gatewayuserpass=${var.gateway-user-pass} gatewaymanageruser=${var.gateway-manager-user} gatewaymanagerpass=${var.gateway-manager-pass} gatewaymanagerruntimeuser=${var.gateway-manager-runtime-user} gatewaymanagerruntimepass=${var.gateway-manager-runtime-pass} clientid=${var.client-id} clientsecret=${var.client-secret} managementurl=${var.management-service-url} gatewayid=${var.gateway-id} apicstoken=${var.apics-token}'"
  }

}

resource "aws_instance" "apics-node-2" {
  ami           = "${var.ami}"  #"ami-0ad99772"
  instance_type = "${var.instance-type}" #"m5.large"
  subnet_id = "${var.public-a}"
  key_name = "${aws_key_pair.dev-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.apics-node.id}"]
  user_data = "${file("configure/userdata.sh")}"

  tags {
    Name = "${var.instance-name} - 2"
    Owner = "${var.owner}"
  }

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > configure/aws_hosts2
# This is a generated file.
[dev]
${aws_instance.apics-node-2.public_ip}

[dev:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
EOD
  }

  # install Java
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.apics-node-2.id} && ansible-playbook -i configure/aws_hosts2 configure/playbook-install-jdk8.yml"
  }

  # build gateway-props.json file...
  provisioner "file" {
    content = <<EOD
{
   "nodeInstallDir"           : "/opt/oracle/gateway",
   "logicalGateway"           : "${var.logical-gateway}",
   "logicalGatewayId"         : "${var.logical-gateway-id}",
   "gatewayNodeName"          : "${var.logical-gateway}-node-2",
   "managementServiceUrl"     : "${var.management-service-url}",
   "listenIpAddress"          : "${aws_instance.apics-node-2.private_ip}",
   "publishAddress"           : "${aws_lb.apics-lb.dns_name}",
   "gatewayExecutionMode"     : "${var.gateway-execution-mode}",
   "idcsUrl"                  : "${var.idcs-url}",
   "requestScope"             : "${var.request-scope}",
   "prevInstallCleanupAction" : "clean",
   "heapSizeGb"               : "2",
   "maximumHeapSizeGb"        : "4"
}
EOD
    destination = "/home/ec2-user/local-gateway-props.json"
    connection {
      type = "ssh"
      user = "ec2-user"
    }
  }

  # install apics gateway
  provisioner "local-exec" {
    command = "ansible-playbook -i configure/aws_hosts2 configure/playbook-install-configure-join-apicsgatewaynode.yml --extra-vars 'gatewayuser=${var.gateway-user} gatewayuserpass=${var.gateway-user-pass} gatewaymanageruser=${var.gateway-manager-user} gatewaymanagerpass=${var.gateway-manager-pass} gatewaymanagerruntimeuser=${var.gateway-manager-runtime-user} gatewaymanagerruntimepass=${var.gateway-manager-runtime-pass} clientid=${var.client-id} clientsecret=${var.client-secret} managementurl=${var.management-service-url} gatewayid=${var.gateway-id} apicstoken=${var.apics-token}'"
  }


}

resource "aws_security_group" "apics-node" {
  name = "apics-node-sg"
  description = "Allow inbound SSH and HTTP traffic from internet"
  vpc_id = "${var.vpc-id}"

  tags {
    Name = "APICS Node SG"
    Owner = "${var.owner}"
  }
}

# SSH Ingress
resource "aws_security_group_rule" "apics-node-ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.apics-node.id}"
}

# HTTP Ingress
resource "aws_security_group_rule" "apics-node-http" {
  type = "ingress"
  from_port = 80
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.apics-node.id}"
}


# HTTP Egress
resource "aws_security_group_rule" "apics-node-http-outbound" {
  type = "egress"
  from_port = 80
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.apics-node.id}"
}

# HTTP Ingress
resource "aws_security_group_rule" "apics-node-http-services" {
  type = "ingress"
  from_port = 8000
  to_port = 8020
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.apics-node.id}"
}

# -----------------------------------
# Load Balancer
# -----------------------------------

resource "aws_security_group" "apics-lb-sg" {
  name = "apics-lb-sg"
  description = "Allow inbound SSH and HTTP traffic from internet"
  vpc_id = "${var.vpc-id}"

  tags {
    Name = "APICS ELB SG"
    Owner = "${var.owner}"
  }
}

# HTTPS Ingress
resource "aws_security_group_rule" "apics-lb-https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.apics-lb-sg.id}"
}

# HTTP Ingress
resource "aws_security_group_rule" "apics-lb-http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.apics-lb-sg.id}"
}

# HTTP Egress
resource "aws_security_group_rule" "apics-lb-http-outbound" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.apics-lb-sg.id}"
}


resource "aws_lb" "apics-lb" {
  name = "apics-lb"
  internal = "false"
  load_balancer_type = "application"
  # The same availability zone as our instance
  subnets = ["${var.public-a}", "${var.public-b}"]
  security_groups = ["${aws_security_group.apics-lb-sg.id}"]

}

// TODO fix health_check path... this should go to managed server...
resource "aws_lb_target_group" "apics-tg" {
  name     = "apics-tg"
  port     = 8011
  protocol = "HTTP"
  vpc_id   = "${var.vpc-id}"
  target_type = "instance"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    port = "8011"
    protocol = "HTTP"
    path                = "/console/css/login.css"
    interval            = 30
  }
}

resource "aws_lb_target_group" "apics-tg-admin" {
  name     = "apics-tg-admin"
  port     = 8001
  protocol = "HTTP"
  vpc_id   = "${var.vpc-id}"
  target_type = "instance"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    port                = "8001"
    protocol            = "HTTP"
    path                = "/console/css/login.css"
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "apics-tg-admin-node1" {
  target_group_arn = "${aws_lb_target_group.apics-tg-admin.arn}"
  target_id        = "${aws_instance.apics-node-1.id}"
  port             = 8001
}

resource "aws_lb_target_group_attachment" "apics-tg-admin-node2" {
  target_group_arn = "${aws_lb_target_group.apics-tg-admin.arn}"
  target_id        = "${aws_instance.apics-node-2.id}"
  port             = 8001
}

resource "aws_lb_target_group_attachment" "apics-tg-node1" {
  target_group_arn = "${aws_lb_target_group.apics-tg.arn}"
  target_id        = "${aws_instance.apics-node-1.id}"
  port             = 8011
}

resource "aws_lb_target_group_attachment" "apics-tg-node2" {
  target_group_arn = "${aws_lb_target_group.apics-tg.arn}"
  target_id        = "${aws_instance.apics-node-2.id}"
  port             = 8011
}

resource "aws_lb_listener" "apics-lb-listener-http" {
  load_balancer_arn = "${aws_lb.apics-lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.apics-tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "console" {
  listener_arn = "${aws_lb_listener.apics-lb-listener-http.arn}"
  priority     = 110

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.apics-tg-admin.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/console*"]
  }
}


